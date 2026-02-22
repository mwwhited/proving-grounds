// ─────────────────────────────────────────────────────────────────────────────
//  Streams a Sierpinski Tetrahedron (Tetrix) to osci-render.
//
//  The tetrahedron is the natural 3D extension of the Sierpinski gasket:
//    - Start with a regular tetrahedron (4 vertices, 6 edges).
//    - Recursively replace each tetrahedron with 4 smaller ones at the corners,
//      removing the central octahedron.
//    - At the leaf level emit the 6 edges of each surviving tetrahedron.
//
//  At depth 4: 4^4 = 256 leaf tetrahedra × 6 edges = 1536 line segments.
//
//  Animation: dual-axis rotation (Y and X) so the 3D structure is always
//  visible. The 4×4 matrix sent to osci-render encodes the full rotation +
//  camera-space translation, so perspective projection is handled by
//  osci-render itself.
//
//  All connection / flow-control / reconnect logic is identical to the
//  circle and gasket versions.
// ─────────────────────────────────────────────────────────────────────────────

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;

class OsciRenderTetrix
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

    // ── Fractal settings ─────────────────────────────────────────────────────
    //  Depth 4 = 1536 edges.  Drop to 3 (384 edges) if you get heavy drops.
    private const int Depth = 4;
    private const double Size = 1.0;
    private const double FocalLength = -0.05 * 50.0;
    private const double CameraDistance = -7.36;

    // Rotation speeds (radians per frame) on each axis — incommensurate so
    // the motion never exactly repeats.
    private const double RotSpeedY = 2.0 * Math.PI / (Fps * 12.0);   // full turn in 12 s
    private const double RotSpeedX = 2.0 * Math.PI / (Fps * 31.7);   // full turn in ~32 s

    // ── Flow control ─────────────────────────────────────────────────────────
    private const int MaxConsecutiveDrops = 3;
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    // ── Pre-built geometry ───────────────────────────────────────────────────
    // Each entry is a pair of 3-D vertices defining one edge of the fractal.
    private static readonly List<(Vec3 a, Vec3 b)> _edges = BuildEdges();

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

        // --static  →  send frame 0 on repeat so osci-render controls rotation
        bool isStatic = args.Length == 1 && args[0] == "--static";

        Console.WriteLine($"Connecting to osci-render on {Host}:{Port}...");
        Console.WriteLine($"Sierpinski Tetrahedron depth {Depth} → {_edges.Count} edges per frame\n");

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

        Console.WriteLine($"Connected! Streaming at {Fps} fps{(isStatic ? " (static — no rotation)" : "")}. Press Ctrl+C to stop.\n");

        try { RunLoop(isStatic); }
        finally { CloseConnection(); }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Geometry
    // ─────────────────────────────────────────────────────────────────────────

    readonly record struct Vec3(double X, double Y, double Z)
    {
        public static Vec3 Midpoint(Vec3 a, Vec3 b) =>
            new((a.X + b.X) / 2, (a.Y + b.Y) / 2, (a.Z + b.Z) / 2);
    }

    static List<(Vec3, Vec3)> BuildEdges()
    {
        // Regular tetrahedron inscribed in a unit sphere, centred at origin.
        // Vertices chosen so one face is roughly horizontal (visually stable).
        double sq8o3 = Math.Sqrt(8.0 / 3.0);   // ≈ 1.633
        double sq2o3 = Math.Sqrt(2.0 / 3.0);   // ≈ 0.816

        var v0 = new Vec3(0, Size, 0);
        var v1 = new Vec3(sq8o3 * Size, -Size / 3.0, 0);
        var v2 = new Vec3(-sq8o3 * Size / 2, -Size / 3.0, sq2o3 * Size);   // corrected
        var v3 = new Vec3(-sq8o3 * Size / 2, -Size / 3.0, -sq2o3 * Size);

        // Normalise each vertex to lie exactly on a sphere of radius Size.
        v0 = Normalise(v0, Size);
        v1 = Normalise(v1, Size);
        v2 = Normalise(v2, Size);
        v3 = Normalise(v3, Size);

        var edges = new List<(Vec3, Vec3)>();
        CollectEdges(v0, v1, v2, v3, Depth, edges);
        return edges;
    }

    static Vec3 Normalise(Vec3 v, double r)
    {
        double len = Math.Sqrt(v.X * v.X + v.Y * v.Y + v.Z * v.Z);
        return new Vec3(v.X / len * r, v.Y / len * r, v.Z / len * r);
    }

    /// <summary>
    /// Recursively subdivide a tetrahedron into 4 smaller corner tetrahedra.
    /// At depth 0 emit the 6 edges of the leaf tetrahedron.
    /// </summary>
    static void CollectEdges(Vec3 a, Vec3 b, Vec3 c, Vec3 d,
                             int depth, List<(Vec3, Vec3)> edges)
    {
        if (depth == 0)
        {
            // 6 edges of one tetrahedron: each pair of the 4 vertices.
            edges.Add((a, b)); edges.Add((a, c)); edges.Add((a, d));
            edges.Add((b, c)); edges.Add((b, d)); edges.Add((c, d));
            return;
        }

        // Midpoints of each of the 6 edges.
        var mab = Vec3.Midpoint(a, b);
        var mac = Vec3.Midpoint(a, c);
        var mad = Vec3.Midpoint(a, d);
        var mbc = Vec3.Midpoint(b, c);
        var mbd = Vec3.Midpoint(b, d);
        var mcd = Vec3.Midpoint(c, d);

        // 4 corner sub-tetrahedra (the central octahedron is removed).
        CollectEdges(a, mab, mac, mad, depth - 1, edges);
        CollectEdges(mab, b, mbc, mbd, depth - 1, edges);
        CollectEdges(mac, mbc, c, mcd, depth - 1, edges);
        CollectEdges(mad, mbd, mcd, d, depth - 1, edges);
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  3D rotation helpers
    // ─────────────────────────────────────────────────────────────────────────

    /// <summary>Rotate around the Y axis.</summary>
    static Vec3 RotateY(Vec3 v, double cos, double sin) =>
        new(v.X * cos + v.Z * sin,
             v.Y,
            -v.X * sin + v.Z * cos);

    /// <summary>Rotate around the X axis.</summary>
    static Vec3 RotateX(Vec3 v, double cos, double sin) =>
        new(v.X,
             v.Y * cos - v.Z * sin,
             v.Y * sin + v.Z * cos);

    // ─────────────────────────────────────────────────────────────────────────
    //  Render loop (unchanged from circle / gasket versions)
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

            // In static mode always send frame 0 — geometry never rotates so
            // osci-render's own rotation controls take full effect.
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
        // Accumulate dual-axis rotation.
        double angleY = frameIndex * RotSpeedY;
        double angleX = frameIndex * RotSpeedX;
        double cosY = Math.Cos(angleY), sinY = Math.Sin(angleY);
        double cosX = Math.Cos(angleX), sinX = Math.Sin(angleX);

        WriteTag(w, "FRAME   ");
        WriteTag(w, "focalLen"); WriteDouble(w, FocalLength);

        WriteTag(w, "OBJECTS ");
        WriteTag(w, "OBJECT  ");

        // Send the full rotation + camera-distance baked into the matrix.
        // This is equivalent to what Blender sends as:
        //   camera.matrix_world.inverted() @ obj.matrix_world
        // We compose: T(0,0,CameraDistance) * Rx(angleX) * Ry(angleY)
        WriteTag(w, "MATRIX  ");
        WriteRotationMatrix(w, cosY, sinY, cosX, sinX, CameraDistance);
        WriteTag(w, "DONE    ");

        WriteTag(w, "STROKES ");

        // Each pre-computed edge becomes a 2-point stroke.
        // We apply the same rotation to the vertices here so that
        // osci-render receives already-rotated geometry — the matrix
        // then only needs to handle the camera-space translation.
        foreach (var (a, b) in _edges)
        {
            var ra = RotateX(RotateY(a, cosY, sinY), cosX, sinX);
            var rb = RotateX(RotateY(b, cosY, sinY), cosX, sinX);

            WriteTag(w, "STROKE  ");
            WriteTag(w, "vertexCt"); WriteInt64(w, 2);
            WriteTag(w, "VERTICES");
            WriteDouble(w, ra.X); WriteDouble(w, ra.Y); WriteDouble(w, ra.Z);
            WriteDouble(w, rb.X); WriteDouble(w, rb.Y); WriteDouble(w, rb.Z);
            WriteTag(w, "DONE    ");
            WriteTag(w, "DONE    ");
        }

        WriteTag(w, "DONE    ");   // end STROKES
        WriteTag(w, "DONE    ");       // end OBJECT
        WriteTag(w, "DONE    ");           // end OBJECTS
        WriteTag(w, "DONE    ");           // end FRAME
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Save to .gpla file for offline debugging
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
            catch (SocketException ex) { Console.WriteLine($"[RECONNECT] Failed: {ex.Message}"); _client = null; _stream = null; Thread.Sleep(500); }
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

    /// <summary>
    /// Writes a 4×4 matrix encoding translation to camera space only.
    /// The rotation is already baked into the vertex positions before writing,
    /// so the matrix is a pure translation: T(0, 0, cameraDistance).
    /// </summary>
    static void WriteRotationMatrix(BinaryWriter w,
                                    double cosY, double sinY,
                                    double cosX, double sinX,
                                    double camDist)
    {
        // We send an identity + camera-distance translation.
        // Rotation is applied to vertices directly above, not via the matrix,
        // because osci-render's perspective divide only uses the Z from the
        // matrix translation — the rotation is fully encoded in the vertices.
        for (int row = 0; row < 4; row++)
            for (int col = 0; col < 4; col++)
            {
                double val = (row == col) ? 1.0 : 0.0;
                if (row == 2 && col == 3) val = camDist;
                WriteDouble(w, val);
            }
    }
}