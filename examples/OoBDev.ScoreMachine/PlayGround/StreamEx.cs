using System.IO;

namespace PlayGround
{
    public static class StreamEx
    {
        private class State
        {
            public int Read { get; }
            public byte[] Packet { get; }
            public Stream Stream { get; }

            public State(int read, byte[] packet, Stream stream)
            {
                this.Read = read;
                this.Packet = packet;
                this.Stream = stream;
            }
        }

        private static int GetBuffer(Stream stream, int bufferSize, out byte[] buffer)
        {
            buffer = new byte[bufferSize];
            return stream.Read(buffer, 0, bufferSize);
        }

        //public static IObservable<byte> ToObservable(this Stream stream, int bufferSize = 1024)
        //{
        //    var bytes = Observable.Start()

        //    //var bytes = Observable.Generate(
        //    //    new State(0, new byte[0], stream),
        //    //    s => s.Read >= 0,
        //    //    s => new State(GetBuffer(s.Stream, bufferSize, out var buffer), buffer, s.Stream),
        //    //    s => s.Packet.Take(s.Read)
        //    //    ).SelectMany(b => b);
        //    return bytes;
        //}


    }
}
