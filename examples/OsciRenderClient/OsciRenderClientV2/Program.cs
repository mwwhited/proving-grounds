// ─────────────────────────────────────────────────────────────────────────────
//  HOW THE BLENDER PROTOCOL WORKS (from the Blender addon source):
//
//  1.  osci-render is the TCP SERVER, listening on localhost:51677
//  2.  You must first put osci-render into Blender mode:
//        → In osci-render, load any .gpla file  -OR-
//        → The Blender addon's "Connect to osci-render" button does this
//      The title bar should read "Rendering from Blender" once connected.
//  3.  The CLIENT (Blender / this program) connects and immediately sends:
//          base64( gpla_binary ) + "\n"       ← one newline-delimited line per frame
//  4.  Every subsequent frame is another line in the same format.
//  5.  To disconnect cleanly, send the literal ASCII string "CLOSE\n"
//
//  ⚠  If osci-render isn't already in Blender mode when you connect, it will
//     accept the TCP connection but silently ignore all data.
//
//  DEBUGGING TIP: Run with --save circle.gpla to write a multi-frame .gpla
//  file you can drag-and-drop into osci-render to verify the binary format
//  before attempting the live socket stream.
// ─────────────────────────────────────────────────────────────────────────────

using System;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;

class OsciRenderCircle
{
    // ── Win32 console control handler ────────────────────────────────────────
    // Fires on Ctrl+C, Ctrl+Break, window close, logoff, and shutdown —
    // including force-kills via Task Manager (CTRL_CLOSE_EVENT).
    // This is the only reliable way to run cleanup on a forced close on Windows.
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool SetConsoleCtrlHandler(ConsoleCtrlDelegate? handler, bool add);

    private delegate bool ConsoleCtrlDelegate(uint ctrlType);

    // Keep a strong reference so the GC doesn't collect the delegate
    // while the native code still holds a pointer to it.
    private static readonly ConsoleCtrlDelegate _ctrlHandler = OnConsoleCtrl;

    private static bool OnConsoleCtrl(uint ctrlType)
    {
        // ctrlType values:
        //   0 = CTRL_C_EVENT
        //   1 = CTRL_BREAK_EVENT
        //   2 = CTRL_CLOSE_EVENT   ← window X / Task Manager "End Task"
        //   5 = CTRL_LOGOFF_EVENT
        //   6 = CTRL_SHUTDOWN_EVENT
        _running = false;
        CloseConnection();

        // Return false so the default handler also runs (important for
        // CTRL_CLOSE_EVENT — returning true would block the OS from closing).
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
    private const int TotalFrames = -1;    // -1 = loop forever until Ctrl+C

    // ── Circle ───────────────────────────────────────────────────────────────
    private const int CircleVertices = 128;
    private const double Radius = 1.0;
    private const double FocalLength = -0.05 * 50.0;   // 50 mm lens equivalent

    // ── Flow control ─────────────────────────────────────────────────────────
    private const int MaxConsecutiveDrops = 3;  // reconnect after this many in a row
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    // ─────────────────────────────────────────────────────────────────────────
    static void Main(string[] args)
    {
        // Native handler: covers Ctrl+C, Ctrl+Break, window X, Task Manager
        // "End Task", logoff, and shutdown — including force-kills.
        SetConsoleCtrlHandler(_ctrlHandler, add: true);

        // Managed fallback for Ctrl+C inside the IDE / dotnet run.
        Console.CancelKeyPress += OnCancel;

        if (int.TryParse(Environment.GetEnvironmentVariable("OSCI_RENDER_PORT"), out var port))
        {
            Port = port;
        }

        // --save <path>  →  write a multi-frame .gpla file for offline testing
        if (args.Length == 2 && args[0] == "--save")
        {
            SaveToFile(args[1]);
            return;
        }

        Console.WriteLine($"Connecting to osci-render on {Host}:{Port}...");
        Console.WriteLine("NOTE: osci-render must already be open and in Blender mode.");
        Console.WriteLine("      (Load a .gpla file in osci-render first, or use the");
        Console.WriteLine("       Blender addon's Connect button to prime it.)\n");

        try
        {
            _client = new TcpClient();
            _client.Connect(Host, Port);

            // If osci-render stops reading (e.g. it's processing a frame),
            // Write() will block until the kernel send buffer is full.
            // A send timeout converts that infinite block into a clean exception
            // so we can handle it gracefully instead of hanging forever.
            _client.SendTimeout = 2000;  // ms — fail fast if buffer is full
            _client.ReceiveTimeout = 2000;

            // Reduce the kernel send buffer so it fills quickly and we get
            // backpressure feedback early rather than queuing dozens of frames.
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
    //  Main render loop — one GPLA packet per frame, paced to exactly 60 fps.
    //
    //  FLOW CONTROL: if osci-render falls behind and the send buffer fills up,
    //  SendFrame() will throw within SendTimeout ms. We catch that, skip the
    //  frame, and try again next tick. This keeps the wall-clock timing correct
    //  even if individual frames are dropped, exactly like a real video encoder
    //  dropping frames under load.
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

                    // Brief pause to let osci-render notice the disconnect
                    Thread.Sleep(500);

                    if (!Reconnect())
                        break;  // couldn't reconnect — give up

                    consecutiveDrops = 0;
                }
            }
            else
            {
                consecutiveDrops = 0;  // reset on any successful send
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

            // If we're already late, skip ahead rather than flooding the socket.
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

    // ─────────────────────────────────────────────────────────────────────────
    //  Send one frame — mirrors send_scene_to_osci_render() from the addon.
    //  Protocol: base64(binary_gpla) + "\n"
    //
    //  Returns:
    //    Ok         — frame sent successfully
    //    Dropped    — send buffer full (timeout); frame skipped, keep going
    //    FatalError — socket is dead; stop the loop
    // ─────────────────────────────────────────────────────────────────────────
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
            // Send buffer full — osci-render is behind. Drop this frame.
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
    //  --save mode: write a multi-frame .gpla file for drag-and-drop testing
    // ─────────────────────────────────────────────────────────────────────────
    static void SaveToFile(string path)
    {
        int frameCount = TotalFrames > 0 ? TotalFrames : 120; // 2 s @ 60 fps
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
    //  GPLA packet — one frame per packet, matching get_gpla_file() in addon
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
        WriteTag(w, "FRAME   ");
        WriteTag(w, "focalLen"); WriteDouble(w, FocalLength);

        WriteTag(w, "OBJECTS ");

        WriteTag(w, "OBJECT  ");

        // In the Blender addon the matrix is camera-space:
        //   camera.matrix_world.inverted() @ obj.matrix_world
        //
        // osci-render uses a perspective divide, so the object must be
        // at a non-zero Z in camera space or everything projects to a dot.
        //
        // A Blender default scene has:
        //   camera at Z=+7.36, pointing down -Z (towards origin)
        //   object at origin
        //
        // camera_space = cam_inv @ obj  →  object is at Z ≈ -7.36
        // (negative because the camera looks down -Z in its own space)
        //
        // We replicate that with a translation matrix T(0, 0, -7.36):
        //   [ 1  0  0   0  ]
        //   [ 0  1  0   0  ]
        //   [ 0  0  1  -7.36]
        //   [ 0  0  0   1  ]
        WriteTag(w, "MATRIX  ");
        WriteCameraSpaceMatrix(w, cameraDistance: -7.36);
        WriteTag(w, "DONE    ");    // end MATRIX

        WriteTag(w, "STROKES ");
        WriteCircleStroke(w, frameIndex);
        WriteTag(w, "DONE    ");    // end STROKES

        WriteTag(w, "DONE    ");        // end OBJECT

        WriteTag(w, "DONE    ");            // end OBJECTS

        WriteTag(w, "DONE    ");            // end FRAME
    }

    static void WriteCircleStroke(BinaryWriter w, int frameIndex)
    {
        // Rotate the circle by a small angle each frame.
        // One full revolution every 2 seconds at 60 fps.
        double rotStep = 2.0 * Math.PI / (Fps * 2.0);
        double angleOffset = frameIndex * rotStep;

        int totalPoints = CircleVertices + 1;  // +1 closes the loop

        WriteTag(w, "STROKE  ");
        WriteTag(w, "vertexCt"); WriteInt64(w, totalPoints);
        WriteTag(w, "VERTICES");
        for (int i = 0; i < totalPoints; i++)
        {
            double angle = angleOffset + 2.0 * Math.PI * i / CircleVertices;
            WriteDouble(w, Radius * Math.Cos(angle));
            WriteDouble(w, Radius * Math.Sin(angle));
            WriteDouble(w, 0.0);
        }
        WriteTag(w, "DONE    ");   // end VERTICES
        WriteTag(w, "DONE    ");       // end STROKE
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Clean disconnect — mirrors close_osci_render() in the addon exactly
    // ─────────────────────────────────────────────────────────────────────────
    static void CloseConnection()
    {
        if (_stream is null && _client is null) return;

        try
        {
            if (_stream is not null)
            {
                // Best-effort CLOSE signal — osci-render may have already stopped
                // reading by the time we get here, so swallow any write errors.
                try
                {
                    _stream.WriteTimeout = 200;  // don't wait long
                    _stream.Write(Encoding.UTF8.GetBytes("CLOSE\n"));
                    _stream.Flush();
                }
                catch { /* ignored — socket may already be unreadable */ }

                _stream.Close();
                _stream = null;
            }
        }
        catch (Exception ex) when (ex is SocketException or IOException or ObjectDisposedException)
        {
            // Ignore — we're closing anyway
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
        e.Cancel = true;   // don't kill the process immediately; let finally run
        _running = false;
        Console.WriteLine("\nCtrl+C — finishing current frame then closing...");
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Binary primitives — match Python struct.pack / int.to_bytes exactly.
    //  BinaryWriter on .NET is always little-endian on all platforms.
    // ─────────────────────────────────────────────────────────────────────────

    static void WriteTag(BinaryWriter w, string tag)
    {
        if (tag.Length != 8)
            throw new ArgumentException($"Tag must be exactly 8 chars: '{tag}'");
        w.Write(Encoding.UTF8.GetBytes(tag));
    }

    static void WriteInt64(BinaryWriter w, long value) => w.Write(value);
    static void WriteDouble(BinaryWriter w, double value) => w.Write(value);

    /// <summary>
    /// Writes a 4×4 column-major translation matrix that places the object
    /// at (0, 0, cameraDistance) in camera space.
    ///
    /// osci-render reads the matrix rows as:
    ///   row 0..3, each with cols 0..3
    /// which is the standard row-major layout Blender uses when iterating
    /// matrix_world[i][j].  The translation lives in column 3 (w[i][3]).
    ///
    /// [ 1  0  0  0 ]   row 0
    /// [ 0  1  0  0 ]   row 1
    /// [ 0  0  1  d ]   row 2   ← d = cameraDistance (negative = in front)
    /// [ 0  0  0  1 ]   row 3
    /// </summary>
    static void WriteCameraSpaceMatrix(BinaryWriter w, double cameraDistance)
    {
        for (int row = 0; row < 4; row++)
            for (int col = 0; col < 4; col++)
            {
                double val = (row == col) ? 1.0 : 0.0;          // identity
                if (row == 2 && col == 3) val = cameraDistance;  // Z translation
                WriteDouble(w, val);
            }
    }
}