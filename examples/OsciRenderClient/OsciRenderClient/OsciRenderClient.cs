using System;
using System.Net.Sockets;
using System.Text;

namespace OsciRenderClient;

public class OsciRenderClient : IDisposable
{
    private TcpClient _client;
    private NetworkStream _stream;

    public void Connect(string host = "localhost", int port = 51622)
    {
        _client = new TcpClient();
        _client.Connect(host, port);
        _stream = _client.GetStream();
    }

    public void SendFrame(OsciFrame frame, int fps = 30)
    {
        var payload = BuildGpla(frame, fps);
        var encoded = Convert.ToBase64String(payload);
        var bytes = Encoding.UTF8.GetBytes(encoded + "\n");
        _stream.Write(bytes, 0, bytes.Length);
        _stream.Flush();
    }

    public void Close()
    {
        var msg = Encoding.UTF8.GetBytes("CLOSE\n");
        _stream?.Write(msg, 0, msg.Length);
        _stream?.Close();
        _client?.Close();
    }

    private byte[] BuildGpla(OsciFrame frame, int fps)
    {
        var buf = new List<byte>();

        // Header
        buf.AddTag("GPLA    ");
        buf.AddUInt64(2); // major
        buf.AddUInt64(0); // minor
        buf.AddUInt64(0); // patch

        // File info
        buf.AddTag("FILE    ");
        buf.AddTag("fCount  "); buf.AddUInt64(1);
        buf.AddTag("fRate   "); buf.AddUInt64((ulong)fps);
        buf.AddTag("DONE    ");

        // Frame
        buf.AddTag("FRAME   ");
        buf.AddTag("focalLen"); buf.AddDouble(frame.FocalLength);

        buf.AddTag("OBJECTS ");
        foreach (var obj in frame.Objects)
        {
            buf.AddTag("OBJECT  ");

            buf.AddTag("MATRIX  ");
            foreach (var val in obj.CameraSpaceMatrix) // 16 doubles, row-major
                buf.AddDouble(val);
            buf.AddTag("DONE    ");

            buf.AddTag("STROKES ");
            foreach (var stroke in obj.Strokes)
            {
                buf.AddTag("STROKE  ");
                buf.AddTag("vertexCt"); buf.AddUInt64((ulong)stroke.Vertices.Count);
                buf.AddTag("VERTICES");
                foreach (var v in stroke.Vertices)
                {
                    buf.AddDouble(v.X);
                    buf.AddDouble(v.Y);
                    buf.AddDouble(v.Z);
                }
                buf.AddTag("DONE    "); // VERTICES
                buf.AddTag("DONE    "); // STROKE
            }
            buf.AddTag("DONE    "); // STROKES
            buf.AddTag("DONE    "); // OBJECT
        }
        buf.AddTag("DONE    "); // OBJECTS
        buf.AddTag("DONE    "); // FRAME

        buf.AddTag("END GPLA");

        return buf.ToArray();
    }

    public void Dispose() => Close();
}
