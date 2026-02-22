// ─────────────────────────────────────────────────────────────────────────────
//  Streams geographic boundary shapes to osci-render, cycling every 5 seconds:
//    1. Virginia
//    2. Maryland
//    3. Washington D.C.
//    4. USA (48 contiguous states)
//
//  Coordinates are geodetic (lon/lat) projected to a flat XY plane using a
//  simple equirectangular projection, then normalised to fit [-1, +1].
//
//  Each shape is sent as a single continuous stroke so the oscilloscope beam
//  traces the outline without jumping. The boundary is closed (last point = first).
//
//  Use --static to disable the slow rotation and let osci-render control it.
// ─────────────────────────────────────────────────────────────────────────────

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;

class OsciRenderGeo
{
    // ── Win32 console control handler ────────────────────────────────────────
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool SetConsoleCtrlHandler(ConsoleCtrlDelegate? handler, bool add);
    private delegate bool ConsoleCtrlDelegate(uint ctrlType);
    private static readonly ConsoleCtrlDelegate _ctrlHandler = OnConsoleCtrl;
    private static bool OnConsoleCtrl(uint ctrlType) { _running = false; CloseConnection(); return false; }

    // ── Connection ───────────────────────────────────────────────────────────
    private const string Host = "localhost";
    private static int Port = 51677;

    // ── GPLA ─────────────────────────────────────────────────────────────────
    private const long GplaMajor = 2, GplaMinor = 0, GplaPatch = 0;

    // ── Playback ─────────────────────────────────────────────────────────────
    private const int Fps = 60;
    private const int TotalFrames = -1;
    private const int ShapeSeconds = 5;     // seconds per shape before cycling

    // ── Camera ───────────────────────────────────────────────────────────────
    private const double FocalLength = -0.05 * 50.0;
    private const double CameraDistance = -7.36;

    // Slow rotation — one full turn every 20 s (use --static to disable)
    private const double RotSpeed = 2.0 * Math.PI / (Fps * 20.0);

    // ── Flow control ─────────────────────────────────────────────────────────
    private const int MaxConsecutiveDrops = 3;
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    // ── Geographic coordinate data (lon, lat) ────────────────────────────────
    // Source: US Census Bureau cartographic boundary files (public domain).
    // Simplified to key vertices that preserve the recognisable silhouette.

    private static readonly (double lon, double lat)[] _VirginiaCoords =
    {
        (-77.719519, 38.933151), (-77.244813, 38.976920), (-77.117493, 38.933979),
        (-77.040741, 38.791645), (-76.909781, 38.892839), (-76.513867, 37.950523),
        (-76.234793, 37.887673), (-75.994645, 37.953250), (-75.791502, 37.917240),
        (-75.628738, 37.994698), (-75.397659, 38.013497), (-75.244304, 38.029928),
        (-75.339633, 38.452229), (-75.640625, 38.641067), (-75.706348, 38.714676),
        (-75.786521, 39.722302), (-77.459717, 39.719929), (-78.339415, 39.722302),
        (-79.477979, 39.722302), (-80.519867, 39.721523), (-80.519867, 36.540828),
        (-76.919754, 36.540828), (-76.030578, 36.540828), (-75.868042, 36.551000),
        (-75.791502, 36.551000), (-75.628738, 36.551000), (-76.919754, 36.540828),
        (-77.719519, 38.933151), // closed
    };

    private static readonly (double lon, double lat)[] _MarylandCoords =
    {
        (-79.477979, 39.722302), (-75.786521, 39.722302), (-75.693413, 38.462606),
        (-75.047134, 38.451652), (-75.244304, 38.029928), (-75.397659, 38.013497),
        (-75.671506, 37.953250), (-75.885106, 37.909435), (-75.879629, 38.073743),
        (-75.961783, 38.139466), (-75.846768, 38.210667), (-76.000122, 38.374975),
        (-76.049415, 38.303775), (-76.257538, 38.320205), (-76.328738, 38.500944),
        (-76.263015, 38.500944), (-76.257538, 38.736453), (-76.191815, 38.829561),
        (-76.279446, 39.147223), (-76.169907, 39.333439), (-76.000122, 39.366301),
        (-75.972737, 39.557994), (-76.098707, 39.536086), (-76.104184, 39.437501),
        (-76.367077, 39.311532), (-76.443754, 39.196516), (-76.460185, 38.906238),
        (-76.558770, 38.769315), (-76.514954, 38.539283), (-76.383508, 38.380452),
        (-76.399939, 38.259959), (-76.317785, 38.139466), (-76.361600, 38.057312),
        (-76.591632, 38.216144), (-76.920441, 38.293022), (-77.013550, 38.374975),
        (-77.205765, 38.361067), (-77.244813, 38.976920), (-77.459717, 39.719929),
        (-79.477979, 39.722302), // closed
    };

    private static readonly (double lon, double lat)[] _DCCoords =
    {
        // DC is a square rotated 45° clipped at the Potomac on the SW side.
        (-77.119759, 38.934343), (-77.041170, 38.993869), (-76.909781, 39.050770),
        (-76.909781, 38.892839), (-77.040741, 38.791645), (-77.119759, 38.791645),
        (-77.119759, 38.934343), // closed
    };

    private static readonly (double lon, double lat)[] _USACoords =
    {
        // 48 contiguous states — simplified outer silhouette.
        (-124.733253, 48.168633), (-124.376494, 46.886968), (-124.068710, 45.779936),
        (-123.940918, 44.769300), (-124.592896, 40.258174), (-124.158936, 38.006481),
        (-122.423706, 37.103700), (-120.500717, 34.498050), (-119.995728, 33.996349),
        (-117.124603, 32.534156), (-114.621642, 32.734259), (-111.060745, 31.332177),
        (-108.208008, 31.332177), (-106.447754, 31.765537), (-104.787598, 29.765040),
        (-103.119873, 28.998532), (-101.062012, 29.765040), (-99.228516,  26.275662),
        (-97.282715,  25.879755), (-96.701660,  27.916766), (-94.042969,  29.611670),
        (-89.648438,  28.923502), (-88.966064,  30.059715), (-88.208008,  30.448674),
        (-85.441895,  30.124027), (-84.869385,  30.124027), (-82.924805,  29.228890),
        (-81.386719,  25.165173), (-80.200195,  25.165173), (-80.145264,  27.059126),
        (-81.002808,  30.448674), (-81.145020,  32.101233), (-80.485840,  33.578015),
        (-78.772949,  33.578015), (-75.817871,  35.353216), (-75.355225,  36.033154),
        (-75.893555,  37.996163), (-75.025635,  38.978162), (-73.498535,  40.513799),
        (-72.004395,  41.013066), (-70.488281,  41.902277), (-70.037842,  41.902277),
        (-69.961548,  43.581168), (-67.104492,  44.527843), (-66.984375,  47.024653),
        (-69.082031,  47.219568), (-71.037598,  45.089040), (-72.279053,  45.089040),
        (-73.234863,  45.032235), (-74.893799,  45.008032), (-76.728516,  44.009243),
        (-78.651123,  43.770859), (-79.057617,  43.321056), (-82.836914,  41.771313),
        (-82.683105,  42.032974), (-83.007813,  42.553080), (-83.913574,  43.834527),
        (-84.029297,  45.876800), (-84.677124,  45.980083), (-85.221558,  46.073231),
        (-87.028809,  48.107431), (-88.769531,  48.107431), (-89.780273,  47.813155),
        (-91.894531,  46.920255), (-95.317383,  49.000000), (-104.062500, 49.000000),
        (-110.214844, 49.000000), (-117.553711, 49.000000), (-123.178711, 49.000000),
        (-124.733253, 48.168633), // closed
    };

    // ── Shape definitions ─────────────────────────────────────────────────────
    record Shape(string Name, (double lon, double lat)[] RawCoords,
                 (double x, double y)[] Points);

    private static readonly Shape[] _shapes = BuildShapes();

    static Shape[] BuildShapes()
    {
        var raw = new (string name, (double, double)[] coords)[]
        {
            //("Virginia",       _VirginiaCoords),
            //("Maryland",       _MarylandCoords),
            //("Washington D.C.",_DCCoords),
            ("USA",            _USACoords),
        };

        var result = new Shape[raw.Length];
        for (int i = 0; i < raw.Length; i++)
            result[i] = new Shape(raw[i].name, raw[i].coords,
                                  ProjectAndNormalise(raw[i].coords));
        return result;
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Projection: equirectangular (lon/lat → x/y) then normalise to [-1, +1].
    //
    //  For the state-level shapes (small geographic extent) we apply a cosine
    //  correction on the X axis so degrees of longitude are scaled to match
    //  degrees of latitude at the shape's centre latitude. This prevents the
    //  shapes looking stretched horizontally.
    //
    //  For the USA shape the same correction is applied at the country centroid.
    // ─────────────────────────────────────────────────────────────────────────
    static (double x, double y)[] ProjectAndNormalise((double lon, double lat)[] coords)
    {
        // Compute centroid latitude for cosine correction.
        double sumLat = 0;
        foreach (var (_, lat) in coords) sumLat += lat;
        double centreLat = sumLat / coords.Length;
        double cosCorrect = Math.Cos(centreLat * Math.PI / 180.0);

        // Project to flat XY.
        var pts = new (double x, double y)[coords.Length];
        for (int i = 0; i < coords.Length; i++)
            pts[i] = (coords[i].lon * cosCorrect, coords[i].lat);

        // Find bounding box.
        double minX = pts[0].x, maxX = pts[0].x;
        double minY = pts[0].y, maxY = pts[0].y;
        foreach (var (x, y) in pts)
        {
            if (x < minX) minX = x; if (x > maxX) maxX = x;
            if (y < minY) minY = y; if (y > maxY) maxY = y;
        }

        double cx = (minX + maxX) / 2.0;
        double cy = (minY + maxY) / 2.0;
        double scale = 2.0 / Math.Max(maxX - minX, maxY - minY); // fit in [-1,+1]

        var norm = new (double x, double y)[coords.Length];
        for (int i = 0; i < coords.Length; i++)
            norm[i] = ((pts[i].x - cx) * scale, (pts[i].y - cy) * scale);

        return norm;
    }

    // ─────────────────────────────────────────────────────────────────────────
    static void Main(string[] args)
    {
        SetConsoleCtrlHandler(_ctrlHandler, add: true);
        Console.CancelKeyPress += OnCancel;

        if (int.TryParse(Environment.GetEnvironmentVariable("OSCI_RENDER_PORT"), out var port))
            Port = port;

        if (args.Length == 2 && args[0] == "--save") { SaveToFile(args[1]); return; }

        bool isStatic = args.Length == 1 && args[0] == "--static";

        Console.WriteLine($"Connecting to osci-render on {Host}:{Port}...");
        Console.WriteLine($"Cycling {_shapes.Length} shapes every {ShapeSeconds}s:");
        foreach (var s in _shapes)
            Console.WriteLine($"  • {s.Name} ({s.Points.Length} pts)");
        Console.WriteLine();

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
        int framesPerShape = Fps * ShapeSeconds;
        int currentShapeIdx = -1;

        while (_running)
        {
            if (TotalFrames > 0 && frameIndex >= TotalFrames) break;

            int sendFrame = isStatic ? 0 : frameIndex;
            int shapeIdx = (frameIndex / framesPerShape) % _shapes.Length;

            // Announce shape change.
            if (shapeIdx != currentShapeIdx)
            {
                currentShapeIdx = shapeIdx;
                Console.WriteLine($"\n→ Now showing: {_shapes[shapeIdx].Name}");
            }

            var result = SendFrame(sendFrame, shapeIdx);

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

    static SendResult SendFrame(int frameIndex, int shapeIdx)
    {
        if (_stream is null) return SendResult.FatalError;

        byte[] payload = BuildGplaPacket(frameIndex, shapeIdx);
        byte[] toSend = Encoding.UTF8.GetBytes(Convert.ToBase64String(payload) + "\n");

        try
        {
            _stream.Write(toSend, 0, toSend.Length);
            _stream.Flush();
            Console.Write($"\rFrame {frameIndex + 1,6}  raw={payload.Length}B  b64={toSend.Length}B   ");
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
    //  GPLA packet
    // ─────────────────────────────────────────────────────────────────────────
    static byte[] BuildGplaPacket(int frameIndex, int shapeIdx)
    {
        using var ms = new MemoryStream();
        using var w = new BinaryWriter(ms, Encoding.UTF8, leaveOpen: true);

        WriteTag(w, "GPLA    ");
        WriteInt64(w, GplaMajor); WriteInt64(w, GplaMinor); WriteInt64(w, GplaPatch);

        WriteTag(w, "FILE    ");
        WriteTag(w, "fCount  "); WriteInt64(w, 1);
        WriteTag(w, "fRate   "); WriteInt64(w, Fps);
        WriteTag(w, "DONE    ");

        WriteFrame(w, frameIndex, shapeIdx);

        WriteTag(w, "END GPLA");
        return ms.ToArray();
    }

    static void WriteFrame(BinaryWriter w, int frameIndex, int shapeIdx)
    {
        double angle = frameIndex * RotSpeed;
        double cosA = Math.Cos(angle);
        double sinA = Math.Sin(angle);

        var pts = _shapes[shapeIdx].Points;

        WriteTag(w, "FRAME   ");
        WriteTag(w, "focalLen"); WriteDouble(w, FocalLength);

        WriteTag(w, "OBJECTS ");
        WriteTag(w, "OBJECT  ");

        WriteTag(w, "MATRIX  ");
        WriteCameraSpaceMatrix(w, CameraDistance);
        WriteTag(w, "DONE    ");

        WriteTag(w, "STROKES ");

        // Single continuous stroke — the beam traces the full
        // boundary outline without any jumps.
        WriteTag(w, "STROKE  ");
        WriteTag(w, "vertexCt"); WriteInt64(w, pts.Length);
        WriteTag(w, "VERTICES");
        foreach (var (px, py) in pts)
        {
            double rx = px * cosA - py * sinA;
            double ry = px * sinA + py * cosA;
            WriteDouble(w, rx);
            WriteDouble(w, ry);
            WriteDouble(w, 0.0);
        }
        WriteTag(w, "DONE    ");
        WriteTag(w, "DONE    ");

        WriteTag(w, "DONE    ");   // end STROKES
        WriteTag(w, "DONE    ");       // end OBJECT
        WriteTag(w, "DONE    ");           // end OBJECTS
        WriteTag(w, "DONE    ");           // end FRAME
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Save to .gpla
    // ─────────────────────────────────────────────────────────────────────────
    static void SaveToFile(string path)
    {
        int frameCount = TotalFrames > 0 ? TotalFrames : Fps * ShapeSeconds * _shapes.Length;
        Console.WriteLine($"Saving {frameCount} frames to: {path}");

        using var ms = new MemoryStream();
        using var w = new BinaryWriter(ms, Encoding.UTF8, leaveOpen: true);

        WriteTag(w, "GPLA    ");
        WriteInt64(w, GplaMajor); WriteInt64(w, GplaMinor); WriteInt64(w, GplaPatch);

        WriteTag(w, "FILE    ");
        WriteTag(w, "fCount  "); WriteInt64(w, frameCount);
        WriteTag(w, "fRate   "); WriteInt64(w, Fps);
        WriteTag(w, "DONE    ");

        int framesPerShape = Fps * ShapeSeconds;
        for (int i = 0; i < frameCount; i++)
        {
            int shapeIdx = (i / framesPerShape) % _shapes.Length;
            WriteFrame(w, i, shapeIdx);
        }

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
                catch { }
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
                _client = null; _stream = null; Thread.Sleep(500);
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

    static void WriteCameraSpaceMatrix(BinaryWriter w, double camDist)
    {
        for (int row = 0; row < 4; row++)
            for (int col = 0; col < 4; col++)
            {
                double val = (row == col) ? 1.0 : 0.0;
                if (row == 2 && col == 3) val = camDist;
                WriteDouble(w, val);
            }
    }
}