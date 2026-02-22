// ─────────────────────────────────────────────────────────────────────────────
//  Streams a Hilbert Curve to osci-render using the GPLA binary protocol.
//
//  The Hilbert Curve is a space-filling curve that visits every point in a
//  grid exactly once. It is ideal for oscilloscopes because it is a single
//  continuous stroke — the beam never has to jump between disconnected
//  segments, eliminating the connecting-line artefact.
//
//  At order N the curve has 4^N - 1 segments and 4^N points.
//  Order 6 = 4096 points, order 7 = 16384 points.
//
//  Animation: the curve slowly rotates and pulses in scale so the structure
//  is always visible. Use --static to hand rotation off to osci-render.
// ─────────────────────────────────────────────────────────────────────────────

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;

class OsciRenderHilbert
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
    private const int Fps = 30;
    private const int TotalFrames = -1;

    // ── Hilbert settings ─────────────────────────────────────────────────────
    //  Order 6 = 4096 points (one stroke).  Lower to 5 (1024 pts) if needed.
    private const int Order = 4;
    private const double Size = 1.0;      // half-width of the curve bbox
    private const double FocalLength = -0.05 * 50.0;
    private const double CameraDistance = -7.36;

    // Slow rotation — one full turn every 20 s
    private const double RotSpeed = 2.0 * Math.PI / (Fps * 20.0);

    // ── Flow control ─────────────────────────────────────────────────────────
    private const int MaxConsecutiveDrops = 3;
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    // ── Pre-built geometry ───────────────────────────────────────────────────
    // The Hilbert curve points in [-Size, +Size] normalised space, built once.
    private static readonly (double x, double y)[] _points = BuildHilbert();

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

        bool isStatic = args.Length == 1 && args[0] == "--static";

        Console.WriteLine($"Connecting to osci-render on {Host}:{Port}...");
        Console.WriteLine($"Hilbert order {Order} → {_points.Length} points (1 continuous stroke)\n");

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

        Console.WriteLine($"Connected! Streaming at {Fps} fps{(isStatic ? " (static)" : "")}. Press Ctrl+C to stop.\n");

        try { RunLoop(isStatic); }
        finally { CloseConnection(); }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Hilbert curve generation
    //
    //  Uses the integer D→(x,y) algorithm:
    //    For each integer index d in [0, 4^order),
    //    compute the (x,y) grid coordinate, then map to [-Size, +Size].
    //
    //  This avoids recursion entirely and is O(N*order) where N = 4^order.
    // ─────────────────────────────────────────────────────────────────────────
    static (double x, double y)[] BuildHilbert()
    {
        int n = 1 << Order;       // grid side length = 2^order
        int total = n * n;            // total points = 4^order
        var pts = new (double, double)[total];
        double half = n / 2.0;         // for centring

        for (int d = 0; d < total; d++)
        {
            int rx, ry, s, t = d;
            int x = 0, y = 0;

            for (s = 1; s < n; s <<= 1)
            {
                rx = 1 & (t >> 1);
                ry = 1 & (t ^ rx);

                // Rotate quadrant if needed
                if (ry == 0)
                {
                    if (rx == 1)
                    {
                        x = s - 1 - x;
                        y = s - 1 - y;
                    }
                    (x, y) = (y, x);
                }

                x += s * rx;
                y += s * ry;
                t >>= 2;
            }

            // Map integer grid [0, n) → [-Size, +Size]
            pts[d] = ((x - half + 0.5) / half * Size,
                      (y - half + 0.5) / half * Size);
        }

        return pts;
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Render loop
    // ─────────────────────────────────────────────────────────────────────────
    static void RunLoop(bool isStatic = false)
    {
        long ticksPerFrame = Stopwatch.Frequency / Fps;
        var sw = Stopwatch.StartNew();
        long nextTick = sw.ElapsedTicks;
        int frameIndex = 0;
        int totalDropped = 0;
        int consecutiveDrops = 0;

        while (_running)
        {
            if (TotalFrames > 0 && frameIndex >= TotalFrames) break;

            var result = SendFrame(isStatic ? 0 : frameIndex);

            if (result == SendResult.FatalError) break;

            if (result == SendResult.Dropped)
            {
                totalDropped++;
                if (++consecutiveDrops >= MaxConsecutiveDrops)
                {
                    Console.WriteLine($"\n[RECONNECT] {consecutiveDrops} consecutive drops — resetting...");
                    CloseConnection();
                    Thread.Sleep(500);
                    if (!Reconnect()) break;
                    consecutiveDrops = 0;
                }
            }
            else { consecutiveDrops = 0; }

            frameIndex++;
            nextTick += ticksPerFrame;

            long remaining = nextTick - sw.ElapsedTicks;
            if (remaining > 0)
            {
                int sleepMs = (int)(remaining * 1000 / Stopwatch.Frequency) - 1;
                if (sleepMs > 0) Thread.Sleep(sleepMs);
                while (sw.ElapsedTicks < nextTick) { }
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
        byte[] toSend = Encoding.UTF8.GetBytes(Convert.ToBase64String(payload) + "\n");

        try
        {
            _stream.Write(toSend, 0, toSend.Length);
            _stream.Flush();
            Console.Write($"\rFrame {frameIndex + 1,6}  ({frameIndex / (double)Fps:F2}s)" +
                          $"  raw={payload.Length}B  b64={toSend.Length}B   ");
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
        WriteInt64(w, GplaMajor); WriteInt64(w, GplaMinor); WriteInt64(w, GplaPatch);

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
        double angle = frameIndex * RotSpeed;
        double cosA = Math.Cos(angle);
        double sinA = Math.Sin(angle);

        WriteTag(w, "FRAME   ");
        WriteTag(w, "focalLen"); WriteDouble(w, FocalLength);

        WriteTag(w, "OBJECTS ");
        WriteTag(w, "OBJECT  ");

        WriteTag(w, "MATRIX  ");
        WriteCameraSpaceMatrix(w, CameraDistance);
        WriteTag(w, "DONE    ");

        WriteTag(w, "STROKES ");

        // The entire Hilbert curve as ONE stroke — the key advantage
        // over the fractal edge-list approach. osci-render traces it
        // as a single continuous sweep with no beam jumps.
        WriteTag(w, "STROKE  ");
        WriteTag(w, "vertexCt"); WriteInt64(w, _points.Length);
        WriteTag(w, "VERTICES");
        foreach (var (px, py) in _points)
        {
            // Apply 2D rotation in XY plane
            double rx = px * cosA - py * sinA;
            double ry = px * sinA + py * cosA;
            WriteDouble(w, rx);
            WriteDouble(w, ry);
            WriteDouble(w, 0.0);
        }
        WriteTag(w, "DONE    ");   // end VERTICES
        WriteTag(w, "DONE    ");        // end STROKE

        WriteTag(w, "DONE    ");   // end STROKES
        WriteTag(w, "DONE    ");       // end OBJECT
        WriteTag(w, "DONE    ");           // end OBJECTS
        WriteTag(w, "DONE    ");           // end FRAME
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Save to .gpla for offline debugging
    // ─────────────────────────────────────────────────────────────────────────
    static void SaveToFile(string path)
    {
        int frameCount = TotalFrames > 0 ? TotalFrames : 120;
        Console.WriteLine($"Saving {frameCount} frames to: {path}");

        using var ms = new MemoryStream();
        using var w = new BinaryWriter(ms, Encoding.UTF8, leaveOpen: true);

        WriteTag(w, "GPLA    ");
        WriteInt64(w, GplaMajor); WriteInt64(w, GplaMinor); WriteInt64(w, GplaPatch);

        WriteTag(w, "FILE    ");
        WriteTag(w, "fCount  "); WriteInt64(w, frameCount);
        WriteTag(w, "fRate   "); WriteInt64(w, Fps);
        WriteTag(w, "DONE    ");

        for (int i = 0; i < frameCount; i++) WriteFrame(w, i);

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
                try { _stream.WriteTimeout = 200; _stream.Write(Encoding.UTF8.GetBytes("CLOSE\n")); _stream.Flush(); }
                catch { /* best-effort */ }
                _stream.Close(); _stream = null;
            }
        }
        catch (Exception ex) when (ex is SocketException or IOException or ObjectDisposedException) { _ = ex; }
        finally { _client?.Close(); _client = null; }
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
                _client.SendTimeout = 2000; _client.ReceiveTimeout = 2000; _client.SendBufferSize = 8192;
                _stream = _client.GetStream();
                Console.WriteLine("[RECONNECT] Reconnected successfully.");
                return true;
            }
            catch (SocketException ex)
            {
                Console.WriteLine($"[RECONNECT] Failed: {ex.Message}");
                _client = null; _stream = null;
                Thread.Sleep(500);
            }
        }
        Console.WriteLine("[RECONNECT] Could not reconnect after 5 attempts. Stopping.");
        _running = false;
        return false;
    }

    static void OnCancel(object? sender, ConsoleCancelEventArgs e)
    {
        e.Cancel = true; _running = false;
        Console.WriteLine("\nCtrl+C — finishing current frame then closing...");
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Binary primitives
    // ─────────────────────────────────────────────────────────────────────────
    static void WriteTag(BinaryWriter w, string tag)
    {
        if (tag.Length != 8) throw new ArgumentException($"Tag must be 8 chars: '{tag}'");
        w.Write(Encoding.UTF8.GetBytes(tag));
    }

    static void WriteInt64(BinaryWriter w, long v) => w.Write(v);
    static void WriteDouble(BinaryWriter w, double v) => w.Write(v);

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