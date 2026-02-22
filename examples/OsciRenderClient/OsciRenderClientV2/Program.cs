using System;
using System.Diagnostics;
using System.Net.Sockets;
using System.Text;
using System.IO;
using System.Threading;

/// <summary>
/// Renders a circle to osci-render at 60 fps using the GPLA binary protocol,
/// simulating the per-frame sends that Blender's depsgraph_update_post handler does.
/// Press Ctrl+C to stop; the connection is cleanly closed on exit.
/// </summary>
class OsciRenderCircle
{
    // ── Connection settings ──────────────────────────────────────────────────
    private const string Host = "localhost";
    private const int Port = 51622;

    // ── GPLA version ─────────────────────────────────────────────────────────
    private const long GplaMajor = 2;
    private const long GplaMinor = 0;
    private const long GplaPatch = 0;

    // ── Playback settings ────────────────────────────────────────────────────
    private const int Fps = 60;
    private const int TotalFrames = 120; // 2 seconds @ 60 fps; set to -1 to loop forever

    // ── Circle settings ───────────────────────────────────────────────────────
    private const int CircleVertices = 128;
    private const double Radius = 1.0;
    private const double FocalLength = -0.05 * 50.0; // equivalent to a 50 mm lens

    // ── State ────────────────────────────────────────────────────────────────
    private static volatile bool _running = true;
    private static TcpClient? _client;
    private static NetworkStream? _stream;

    static void Main()
    {
        // Cleanly handle Ctrl+C
        Console.CancelKeyPress += OnCancel;

        Console.WriteLine("Connecting to osci-render...");

        try
        {
            _client = new TcpClient();
            _client.Connect(Host, Port);
            _stream = _client.GetStream();
        }
        catch (SocketException ex)
        {
            Console.WriteLine($"Could not connect: {ex.Message}");
            Console.WriteLine("Make sure osci-render is running first.");
            return;
        }

        Console.WriteLine($"Connected! Streaming circle at {Fps} fps. Press Ctrl+C to stop.");

        try
        {
            RunLoop();
        }
        finally
        {
            // Always close cleanly regardless of how we exit the loop.
            CloseConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Main render loop — mimics Blender's frame_change_pre handler firing at
    //  60 fps, sending one GPLA packet per frame over the socket.
    // ─────────────────────────────────────────────────────────────────────────

    static void RunLoop()
    {
        long ticksPerFrame = Stopwatch.Frequency / Fps;
        var sw = Stopwatch.StartNew();
        long nextTick = sw.ElapsedTicks;
        int frameIndex = 0;

        while (_running)
        {
            if (TotalFrames > 0 && frameIndex >= TotalFrames)
                break;

            SendFrame(frameIndex);

            frameIndex++;
            nextTick += ticksPerFrame;

            // Sleep for the remainder of this frame's budget.
            long remaining = nextTick - sw.ElapsedTicks;
            if (remaining > 0)
            {
                // Convert ticks → milliseconds, sleep most of the remaining time,
                // then spin for sub-millisecond precision.
                int sleepMs = (int)(remaining * 1000 / Stopwatch.Frequency) - 1;
                if (sleepMs > 0)
                    Thread.Sleep(sleepMs);

                while (sw.ElapsedTicks < nextTick) { /* spin */ }
            }
        }

        Console.WriteLine($"\nFinished sending {frameIndex} frames.");
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Per-frame send  (mirrors send_scene_to_osci_render in the addon)
    // ─────────────────────────────────────────────────────────────────────────

    static void SendFrame(int frameIndex)
    {
        if (_stream is null) return;

        byte[] payload = BuildGplaPacket(frameIndex);

        // Protocol: base64(binary) + "\n"
        string b64 = Convert.ToBase64String(payload);
        byte[] toSend = Encoding.UTF8.GetBytes(b64 + "\n");

        try
        {
            _stream.Write(toSend, 0, toSend.Length);
            _stream.Flush();
            Console.Write($"\rFrame {frameIndex + 1} sent ({payload.Length} bytes raw)   ");
        }
        catch (Exception ex) when (ex is SocketException or IOException)
        {
            Console.WriteLine($"\nSocket error on frame {frameIndex}: {ex.Message}");
            _running = false;
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  GPLA packet builder — one frame per packet (matches the Blender addon's
    //  get_gpla_file which wraps only the current frame)
    // ─────────────────────────────────────────────────────────────────────────

    static byte[] BuildGplaPacket(int frameIndex)
    {
        using var ms = new MemoryStream();
        using var w = new BinaryWriter(ms, Encoding.UTF8, leaveOpen: true);

        // ── Header ───────────────────────────────────────────────────────────
        WriteTag(w, "GPLA    ");
        WriteInt64(w, GplaMajor);
        WriteInt64(w, GplaMinor);
        WriteInt64(w, GplaPatch);

        // ── File info ────────────────────────────────────────────────────────
        WriteTag(w, "FILE    ");
        WriteTag(w, "fCount  "); WriteInt64(w, 1);   // one frame per packet
        WriteTag(w, "fRate   "); WriteInt64(w, Fps);
        WriteTag(w, "DONE    ");

        // ── Frame ────────────────────────────────────────────────────────────
        WriteFrame(w, frameIndex);

        // ── End marker ───────────────────────────────────────────────────────
        WriteTag(w, "END GPLA");

        return ms.ToArray();
    }

    static void WriteFrame(BinaryWriter w, int frameIndex)
    {
        WriteTag(w, "FRAME   ");
        WriteTag(w, "focalLen"); WriteDouble(w, FocalLength);

        WriteTag(w, "OBJECTS ");

        WriteTag(w, "OBJECT  ");

        WriteTag(w, "MATRIX  ");
        WriteIdentityMatrix(w);
        WriteTag(w, "DONE    "); // end MATRIX

        WriteTag(w, "STROKES ");
        WriteCircleStroke(w, frameIndex);
        WriteTag(w, "DONE    "); // end STROKES

        WriteTag(w, "DONE    "); // end OBJECT

        WriteTag(w, "DONE    "); // end OBJECTS

        WriteTag(w, "DONE    "); // end FRAME
    }

    static void WriteCircleStroke(BinaryWriter w, int frameIndex)
    {
        // Rotate the circle slightly each frame to make the animation visible.
        double rotationPerFrame = 2.0 * Math.PI / (Fps * 2); // one full spin every 2 s
        double offset = frameIndex * rotationPerFrame;

        var points = new (double x, double y, double z)[CircleVertices + 1];
        for (int i = 0; i <= CircleVertices; i++)
        {
            double angle = offset + 2.0 * Math.PI * i / CircleVertices;
            points[i] = (
                x: Radius * Math.Cos(angle),
                y: Radius * Math.Sin(angle),
                z: 0.0
            );
        }

        WriteTag(w, "STROKE  ");

        WriteTag(w, "vertexCt"); WriteInt64(w, points.Length);

        WriteTag(w, "VERTICES");
        foreach (var (x, y, z) in points)
        {
            WriteDouble(w, x);
            WriteDouble(w, y);
            WriteDouble(w, z);
        }
        WriteTag(w, "DONE    "); // end VERTICES

        WriteTag(w, "DONE    "); // end STROKE
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Connection teardown — mirrors the addon's close_osci_render()
    // ─────────────────────────────────────────────────────────────────────────

    static void CloseConnection()
    {
        if (_stream is null && _client is null) return;

        Console.WriteLine("\nClosing connection...");
        try
        {
            if (_stream is not null)
            {
                // Tell osci-render we're done, exactly as the Blender addon does.
                byte[] closeMsg = Encoding.UTF8.GetBytes("CLOSE\n");
                _stream.Write(closeMsg, 0, closeMsg.Length);
                _stream.Flush();
                _stream.Close();
                _stream = null;
            }
        }
        catch (Exception ex) when (ex is SocketException or IOException or ObjectDisposedException)
        {
            // Socket may already be dead — that's fine.
            Console.WriteLine($"(Socket already closed: {ex.Message})");
        }
        finally
        {
            _client?.Close();
            _client = null;
            Console.WriteLine("Connection closed.");
        }
    }

    static void OnCancel(object? sender, ConsoleCancelEventArgs e)
    {
        e.Cancel = true; // prevent immediate process kill so finally blocks run
        _running = false;
        Console.WriteLine("\nCtrl+C received — stopping...");
    }

    // ─────────────────────────────────────────────────────────────────────────
    //  Primitive writers
    // ─────────────────────────────────────────────────────────────────────────

    static void WriteTag(BinaryWriter w, string tag)
    {
        if (tag.Length != 8)
            throw new ArgumentException($"Tag must be exactly 8 chars: '{tag}'");
        w.Write(Encoding.UTF8.GetBytes(tag));
    }

    static void WriteInt64(BinaryWriter w, long value) => w.Write(value);

    static void WriteDouble(BinaryWriter w, double value) => w.Write(value);

    static void WriteIdentityMatrix(BinaryWriter w)
    {
        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 4; j++)
                WriteDouble(w, i == j ? 1.0 : 0.0);
    }
}