// ─────────────────────────────────────────────────────────────────────────────
//  Streams a Koch Snowflake to osci-render using the GPLA binary protocol.
//
//  The Koch Snowflake is built by starting with an equilateral triangle and
//  recursively replacing each edge with a 4-segment "bump":
//
//    Original:  A────────────────B
//    Replaced:  A──C    E──B
//                   \  /
//                    D
//
//  Where C = 1/3, D = the apex of an equilateral triangle on the middle
//  third, E = 2/3 along the original edge.
//
//  At depth N the snowflake has 3 × 4^N line segments.
//  Depth 5 = 3072 segments across 3 outer strokes (one per original edge).
//
//  Unlike the Hilbert curve, the snowflake IS made of separate strokes —
//  one per side of the original triangle — but each stroke is itself a
//  continuous polyline, so beam jumps only happen 3 times per frame.
//
//  Animation: slow rotation + optional morph between depths for a
//  "growing snowflake" effect.  Use --static to disable rotation.
// ─────────────────────────────────────────────────────────────────────────────

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;

class OsciRenderKoch
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
    private const int TotalFrames = -1;

    // ── Koch settings ────────────────────────────────────────────────────────
    //  Depth 5 = 3 × 4^5 = 3072 segments.  Drop to 4 (192 segs) if needed.
    private const int Depth = 2;
    private const double Size = 1.0;    // circumradius of base triangle
    private const double FocalLength = -0.05 * 50.0;
    private const double CameraDistance = -7.36;

    // Slow rotation — one full turn every 15 s
    private const double RotSpeed = 2.0 * Math.PI / (Fps * 15.0);

    // ── Flow control ─────────────────────────────────────────────────────────
    private const int MaxConsecutiveDrops = 3;
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    // ── Pre-built geometry ───────────────────────────────────────────────────
    // Three polylines — one per side of the original triangle.
    // Each is a list of (x,y) points defining a continuous stroke.
    private static readonly List<(double x, double y)>[] _sides = BuildSnowflake();

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

        int totalPts = 0;
        foreach (var s in _sides) totalPts += s.Count;
        Console.WriteLine($"Connecting to osci-render on {Host}:{Port}...");
        Console.WriteLine($"Koch Snowflake depth {Depth} → {totalPts} points across 3 strokes\n");

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
    //  Koch curve geometry
    //
    //  KochPoints(a, b, depth) returns the ordered list of points along the
    //  Koch curve from a to b at the given recursion depth.
    //
    //  At depth 0 this is just [a, b].
    //  At depth 1: [a, c, d, e, b] where:
    //    c = a + (b-a)/3
    //    d = apex of equilateral triangle on middle third (rotated 60° outward)
    //    e = a + 2*(b-a)/3
    //
    //  The snowflake is three such curves joined head-to-tail, one per side
    //  of the base equilateral triangle, bumps pointing outward.
    // ─────────────────────────────────────────────────────────────────────────

    record struct V2(double X, double Y)
    {
        public static V2 operator +(V2 a, V2 b) => new(a.X + b.X, a.Y + b.Y);
        public static V2 operator -(V2 a, V2 b) => new(a.X - b.X, a.Y - b.Y);
        public static V2 operator *(V2 a, double s) => new(a.X * s, a.Y * s);

        /// <summary>Rotate 60° counter-clockwise.</summary>
        public V2 Rot60() => new(X * 0.5 - Y * (Math.Sqrt(3) / 2),
                                 X * (Math.Sqrt(3) / 2) + Y * 0.5);
    }

    static List<(double, double)>[] BuildSnowflake()
    {
        // Base equilateral triangle vertices (pointing up), circumradius = Size.
        var v0 = new V2(0, Size);
        var v1 = new V2(-Size * Math.Sqrt(3) / 2, -Size * 0.5);
        var v2 = new V2(Size * Math.Sqrt(3) / 2, -Size * 0.5);

        // Three sides, bumps pointing outward (= away from centroid at origin).
        // Outward means the apex D is rotated -60° (clockwise) relative to the
        // direction a→b, which places it outside the triangle.
        var sides = new List<(double, double)>[3];
        var verts = new[] { v0, v1, v2 };

        for (int i = 0; i < 3; i++)
        {
            var a = verts[i];
            var b = verts[(i + 1) % 3];
            var pts = new List<(double, double)>();
            KochPoints(a, b, Depth, pts);
            // KochPoints adds all points including the start but not the end
            // (to avoid duplicating the join point). Add the final endpoint.
            pts.Add((b.X, b.Y));
            sides[i] = pts;
        }

        return sides;
    }

    /// <summary>
    /// Recursively append Koch curve points from a to b into the list.
    /// The start point (a) IS appended; the end point (b) is NOT (caller adds it).
    /// </summary>
    static void KochPoints(V2 a, V2 b, int depth, List<(double, double)> pts)
    {
        if (depth == 0)
        {
            pts.Add((a.X, a.Y));
            return;
        }

        V2 d = b - a;
        V2 c = a + d * (1.0 / 3.0);           // 1/3 point
        V2 e = a + d * (2.0 / 3.0);           // 2/3 point

        // Apex: start at c, add the middle-third vector rotated -60° (outward).
        // Rotating d/3 by -60° gives the outward-pointing apex direction.
        V2 third = d * (1.0 / 3.0);
        // -60° rotation: (x,y) → (x*0.5 + y*sqrt3/2, -x*sqrt3/2 + y*0.5)
        double sq3o2 = Math.Sqrt(3) / 2.0;
        V2 rotated = new(third.X * 0.5 + third.Y * sq3o2,
                        -third.X * sq3o2 + third.Y * 0.5);
        V2 apex = c + rotated;

        KochPoints(a, c, depth - 1, pts);
        KochPoints(c, apex, depth - 1, pts);
        KochPoints(apex, e, depth - 1, pts);
        KochPoints(e, b, depth - 1, pts);
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

        // Three strokes — one per side of the base triangle.
        // Each is a continuous polyline so there are only 3 beam jumps
        // per frame (between the end of one side and the start of the next).
        foreach (var side in _sides)
        {
            WriteTag(w, "STROKE  ");
            WriteTag(w, "vertexCt"); WriteInt64(w, side.Count);
            WriteTag(w, "VERTICES");
            foreach (var (px, py) in side)
            {
                double rx = px * cosA - py * sinA;
                double ry = px * sinA + py * cosA;
                WriteDouble(w, rx);
                WriteDouble(w, ry);
                WriteDouble(w, 0.0);
            }
            WriteTag(w, "DONE    ");   // end VERTICES
            WriteTag(w, "DONE    ");        // end STROKE
        }

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