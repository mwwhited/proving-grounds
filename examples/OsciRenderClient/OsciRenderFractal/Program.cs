// ─────────────────────────────────────────────────────────────────────────────
//  Streams a Sierpinski gasket to osci-render using the GPLA binary protocol.
//
//  The gasket is rendered as a set of line strokes — one stroke per triangle
//  edge at each level of recursion. This gives osci-render distinct line
//  segments to trace, producing the characteristic oscilloscope look.
//
//  Animation: the whole gasket slowly rotates in the XY plane.
//
//  Connection protocol is identical to OsciRenderCircle — see that file for
//  full protocol notes.
// ─────────────────────────────────────────────────────────────────────────────

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;

class OsciRenderSierpinski
{
    // ── Win32 console control handler ────────────────────────────────────────
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool SetConsoleCtrlHandler(ConsoleCtrlDelegate? handler, bool add);
    private delegate bool ConsoleCtrlDelegate(uint ctrlType);
    private static readonly ConsoleCtrlDelegate _ctrlHandler = OnConsoleCtrl;

    private static bool OnConsoleCtrl(uint ctrlType)
    {
        _running = false;
        CloseConnection();
        return false;
    }

    // ── Connection ───────────────────────────────────────────────────────────
    private const string Host = "localhost";
    private static int Port = 51677;

    // ── GPLA version ─────────────────────────────────────────────────────────
    private const long GplaMajor = 2;
    private const long GplaMinor = 0;
    private const long GplaPatch = 0;

    // ── Playback ─────────────────────────────────────────────────────────────
    private const int Fps = 60;
    private const int TotalFrames = -1;   // -1 = loop forever until Ctrl+C

    // ── Sierpinski settings ───────────────────────────────────────────────────
    private const int Depth = 5;      // recursion depth (5 = 3^5 = 243 triangles)
    private const double Size = 1.0;    // radius of the outer triangle
    private const double FocalLength = -0.05 * 50.0;
    private const double CameraDistance = -7.36;

    // ── Flow control ─────────────────────────────────────────────────────────
    private const int MaxConsecutiveDrops = 3;
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    // ── Pre-built geometry ───────────────────────────────────────────────────
    // The gasket shape is the same every frame (only rotation changes), so we
    // compute all the triangle edges once at startup rather than per-frame.
    private static readonly List<(double ax, double ay, double bx, double by)> _edges = BuildEdges();

    // ─────────────────────────────────────────────────────────────────────────
    static void Main(string[] args)
    {
        SetConsoleCtrlHandler(_ctrlHandler, add: true);
        Console.CancelKeyPress += OnCancel;

        if (int.TryParse(Environment.GetEnvironmentVariable("OSCI_RENDER_PORT"), out var port))
            Port = port;

        if (args.Length == 2 && args[0] == "--save")
        {
            SaveToFile(args[1]);
            return;
        }

        Console.WriteLine($"Connecting to osci-render on {Host}:{Port}...");
        Console.WriteLine($"Sierpinski depth {Depth} → {_edges.Count} edges per frame\n");

        try
        {
            _client = new TcpClient();
            _client.Connect(Host, Port);
            _client.SendTimeout = 2000;
            _client.ReceiveTimeout = 2000;
            _client.SendBufferSize = 8192;
            _stream = _client.GetStream();
        }
        catch (SocketException ex)
        {
            Console.WriteLine($"[ERROR] Could not connect: {ex.Message}");
            return;
        }

        Console.WriteLine($"Connected! Streaming at {Fps} fps. Press Ctrl+C to stop.\n");

        try
        {
            RunLoop();
        }
        finally
        {
            CloseConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Geometry — Sierpinski gasket edge list
    //
    //  We use the recursive subdivision approach:
    //    - Start with one equilateral triangle.
    //    - Recursively replace each triangle with 3 smaller ones by taking
    //      the midpoints of each edge, removing the central triangle.
    //    - At the leaf level, emit the 3 edges of each surviving triangle
    //      as individual strokes.
    //
    //  This produces clean, non-overlapping line segments that osci-render
    //  traces individually — giving the fractal its characteristic look on
    //  an oscilloscope.
    // ─────────────────────────────────────────────────────────────────────────

    record struct Vec2(double X, double Y);

    static List<(double ax, double ay, double bx, double by)> BuildEdges()
    {
        var edges = new List<(double, double, double, double)>();

        // Equilateral triangle vertices, centred at origin, pointing up.
        var a = new Vec2(0, Size);
        var b = new Vec2(-Size * Math.Sqrt(3) / 2.0, -Size * 0.5);
        var c = new Vec2(Size * Math.Sqrt(3) / 2.0, -Size * 0.5);

        CollectEdges(a, b, c, Depth, edges);
        return edges;
    }

    static void CollectEdges(Vec2 a, Vec2 b, Vec2 c, int depth,
                             List<(double, double, double, double)> edges)
    {
        if (depth == 0)
        {
            // Leaf triangle — emit its 3 edges as strokes.
            edges.Add((a.X, a.Y, b.X, b.Y));
            edges.Add((b.X, b.Y, c.X, c.Y));
            edges.Add((c.X, c.Y, a.X, a.Y));
            return;
        }

        // Midpoints of each edge.
        var mab = new Vec2((a.X + b.X) / 2, (a.Y + b.Y) / 2);
        var mbc = new Vec2((b.X + c.X) / 2, (b.Y + c.Y) / 2);
        var mca = new Vec2((c.X + a.X) / 2, (c.Y + a.Y) / 2);

        // Recurse into the 3 corner sub-triangles (skip the central one).
        CollectEdges(a, mab, mca, depth - 1, edges);
        CollectEdges(mab, b, mbc, depth - 1, edges);
        CollectEdges(mca, mbc, c, depth - 1, edges);
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Render loop
    // ─────────────────────────────────────────────────────────────────────────
    static void RunLoop()
    {
        long ticksPerFrame = Stopwatch.Frequency / Fps;
        var sw = Stopwatch.StartNew();
        long nextTick = sw.ElapsedTicks;
        int frameIndex = 0;
        int totalDropped = 0;
        int consecutiveDrops = 0;

        while (_running)
        {
            if (TotalFrames > 0 && frameIndex >= TotalFrames)
                break;

            SendResult result = SendFrame(frameIndex);

            if (result == SendResult.FatalError)
                break;

            if (result == SendResult.Dropped)
            {
                totalDropped++;
                consecutiveDrops++;

                if (consecutiveDrops >= MaxConsecutiveDrops)
                {
                    Console.WriteLine($"\n[RECONNECT] {consecutiveDrops} consecutive drops — resetting connection...");
                    CloseConnection();
                    Thread.Sleep(500);

                    if (!Reconnect())
                        break;

                    consecutiveDrops = 0;
                }
            }
            else
            {
                consecutiveDrops = 0;
            }

            frameIndex++;
            nextTick += ticksPerFrame;

            long remaining = nextTick - sw.ElapsedTicks;
            if (remaining > 0)
            {
                int sleepMs = (int)(remaining * 1000 / Stopwatch.Frequency) - 1;
                if (sleepMs > 0)
                    Thread.Sleep(sleepMs);
                while (sw.ElapsedTicks < nextTick) { /* precision spin */ }
            }

            while (sw.ElapsedTicks > nextTick)
            {
                nextTick += ticksPerFrame;
                frameIndex++;
                totalDropped++;
            }
        }

        if (totalDropped > 0)
            Console.WriteLine($"\nTotal frames dropped: {totalDropped}");
    }

    enum SendResult { Ok, Dropped, FatalError }

    static SendResult SendFrame(int frameIndex)
    {
        if (_stream is null) return SendResult.FatalError;

        byte[] payload = BuildGplaPacket(frameIndex);
        string b64 = Convert.ToBase64String(payload);
        byte[] toSend = Encoding.UTF8.GetBytes(b64 + "\n");

        try
        {
            _stream.Write(toSend, 0, toSend.Length);
            _stream.Flush();
            double elapsed = (double)frameIndex / Fps;
            Console.Write($"\rFrame {frameIndex + 1,6}  ({elapsed:F2}s)  raw={payload.Length}B  b64={toSend.Length}B   ");
            return SendResult.Ok;
        }
        catch (IOException ex) when (ex.InnerException is SocketException sx &&
                                     sx.SocketErrorCode == SocketError.TimedOut)
        {
            Console.Write($"\r[DROP] Frame {frameIndex + 1} skipped (buffer full)          ");
            return SendResult.Dropped;
        }
        catch (Exception ex) when (ex is SocketException or IOException or ObjectDisposedException)
        {
            Console.WriteLine($"\n[ERROR] Socket lost on frame {frameIndex}: {ex.Message}");
            _running = false;
            return SendResult.FatalError;
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  GPLA packet builder
    // ─────────────────────────────────────────────────────────────────────────
    static byte[] BuildGplaPacket(int frameIndex)
    {
        using var ms = new MemoryStream();
        using var w = new BinaryWriter(ms, Encoding.UTF8, leaveOpen: true);

        WriteTag(w, "GPLA    ");
        WriteInt64(w, GplaMajor);
        WriteInt64(w, GplaMinor);
        WriteInt64(w, GplaPatch);

        WriteTag(w, "FILE    ");
        WriteTag(w, "fCount  "); WriteInt64(w, 1);
        WriteTag(w, "fRate   "); WriteInt64(w, Fps);
        WriteTag(w, "DONE    ");

        WriteFrame(w, frameIndex);

        WriteTag(w, "END GPLA");

        return ms.ToArray();
    }

    static void WriteFrame(BinaryWriter w, int frameIndex)
    {
        // Rotate once every 10 seconds.
        double rotation = frameIndex * (2.0 * Math.PI / (Fps * 10.0));
        double cosR = Math.Cos(rotation);
        double sinR = Math.Sin(rotation);

        WriteTag(w, "FRAME   ");
        WriteTag(w, "focalLen"); WriteDouble(w, FocalLength);

        WriteTag(w, "OBJECTS ");

        WriteTag(w, "OBJECT  ");

        WriteTag(w, "MATRIX  ");
        WriteCameraSpaceMatrix(w, CameraDistance);
        WriteTag(w, "DONE    ");

        WriteTag(w, "STROKES ");

        // Each edge of the gasket becomes one 2-point stroke.
        // osci-render traces each stroke as a line segment — perfect
        // for reproducing the fractal's sharp edges on an oscilloscope.
        foreach (var (ax, ay, bx, by) in _edges)
        {
            // Rotate the two endpoints around the Z axis.
            double rax = ax * cosR - ay * sinR;
            double ray = ax * sinR + ay * cosR;
            double rbx = bx * cosR - by * sinR;
            double rby = bx * sinR + by * cosR;

            WriteTag(w, "STROKE  ");
            WriteTag(w, "vertexCt"); WriteInt64(w, 2);
            WriteTag(w, "VERTICES");
            WriteDouble(w, rax); WriteDouble(w, ray); WriteDouble(w, 0.0);
            WriteDouble(w, rbx); WriteDouble(w, rby); WriteDouble(w, 0.0);
            WriteTag(w, "DONE    ");  // end VERTICES
            WriteTag(w, "DONE    ");       // end STROKE
        }

        WriteTag(w, "DONE    ");   // end STROKES

        WriteTag(w, "DONE    ");       // end OBJECT

        WriteTag(w, "DONE    ");           // end OBJECTS

        WriteTag(w, "DONE    ");           // end FRAME
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Save all frames to a .gpla file (offline debugging / manual load)
    // ─────────────────────────────────────────────────────────────────────────
    static void SaveToFile(string path)
    {
        int frameCount = TotalFrames > 0 ? TotalFrames : 120;
        Console.WriteLine($"Saving {frameCount} frames to: {path}");

        using var ms = new MemoryStream();
        using var w = new BinaryWriter(ms, Encoding.UTF8, leaveOpen: true);

        WriteTag(w, "GPLA    ");
        WriteInt64(w, GplaMajor);
        WriteInt64(w, GplaMinor);
        WriteInt64(w, GplaPatch);

        WriteTag(w, "FILE    ");
        WriteTag(w, "fCount  "); WriteInt64(w, frameCount);
        WriteTag(w, "fRate   "); WriteInt64(w, Fps);
        WriteTag(w, "DONE    ");

        for (int i = 0; i < frameCount; i++)
            WriteFrame(w, i);

        WriteTag(w, "END GPLA");

        File.WriteAllBytes(path, ms.ToArray());
        Console.WriteLine($"Done — {ms.Length:N0} bytes written.");
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Connection management
    // ─────────────────────────────────────────────────────────────────────────
    static void CloseConnection()
    {
        if (_stream is null && _client is null) return;

        try
        {
            if (_stream is not null)
            {
                try
                {
                    _stream.WriteTimeout = 200;
                    _stream.Write(Encoding.UTF8.GetBytes("CLOSE\n"));
                    _stream.Flush();
                }
                catch { /* best-effort */ }

                _stream.Close();
                _stream = null;
            }
        }
        catch (Exception ex) when (ex is SocketException or IOException or ObjectDisposedException)
        {
            _ = ex;
        }
        finally
        {
            _client?.Close();
            _client = null;
        }
    }

    static bool Reconnect()
    {
        for (int attempt = 1; attempt <= 5; attempt++)
        {
            Console.WriteLine($"[RECONNECT] Attempt {attempt}/5...");
            try
            {
                _client = new TcpClient();
                _client.Connect(Host, Port);
                _client.SendTimeout = 2000;
                _client.ReceiveTimeout = 2000;
                _client.SendBufferSize = 8192;
                _stream = _client.GetStream();
                Console.WriteLine("[RECONNECT] Reconnected successfully.");
                return true;
            }
            catch (SocketException ex)
            {
                Console.WriteLine($"[RECONNECT] Failed: {ex.Message}");
                _client = null;
                _stream = null;
                Thread.Sleep(500);
            }
        }

        Console.WriteLine("[RECONNECT] Could not reconnect after 5 attempts. Stopping.");
        _running = false;
        return false;
    }

    static void OnCancel(object? sender, ConsoleCancelEventArgs e)
    {
        e.Cancel = true;
        _running = false;
        Console.WriteLine("\nCtrl+C — finishing current frame then closing...");
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Binary primitives
    // ─────────────────────────────────────────────────────────────────────────

    static void WriteTag(BinaryWriter w, string tag)
    {
        if (tag.Length != 8)
            throw new ArgumentException($"Tag must be exactly 8 chars: '{tag}'");
        w.Write(Encoding.UTF8.GetBytes(tag));
    }

    static void WriteInt64(BinaryWriter w, long value) => w.Write(value);
    static void WriteDouble(BinaryWriter w, double value) => w.Write(value);

    static void WriteCameraSpaceMatrix(BinaryWriter w, double cameraDistance)
    {
        for (int row = 0; row < 4; row++)
            for (int col = 0; col < 4; col++)
            {
                double val = (row == col) ? 1.0 : 0.0;
                if (row == 2 && col == 3) val = cameraDistance;
                WriteDouble(w, val);
            }
    }
}