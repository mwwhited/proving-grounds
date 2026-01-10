using Mono.Unix;
using System;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Tools.AfUnix
{
    class Program
    {
        // https://blogs.msdn.microsoft.com/commandline/2018/02/07/windowswsl-interop-with-af_unix/
        // https://github.com/mono/mono/blob/master/mcs/class/Mono.Posix/Mono.Unix/UnixEndPoint.cs
        // https://stackoverflow.com/questions/40195290/how-to-connect-to-a-unix-domain-socket-in-net-core-in-c-sharp
        static void Main(string[] args)
        {
            var socketPath = args.FirstOrDefault() ?? GetUnixPipeName();
            var unixEP = new UnixEndPoint(socketPath);
            using (var socket = new Socket(AddressFamily.Unix, SocketType.Stream, ProtocolType.Unspecified))
            {
                var bind = File.Exists(socketPath);
                try
                {
                    if (!bind)
                    {
                        Console.WriteLine("Binding");
                        socket.Bind(unixEP);
                        Console.WriteLine("Bound");
                        Console.WriteLine("Listen");
                        socket.Listen(1);
                        Console.WriteLine("Listening");
                        Console.WriteLine("Accepting");
                        var client = socket.Accept();
                        Console.WriteLine("Accepted");
                    }
                    else
                    {
                        Console.WriteLine("Connecting");
                        socket.Connect(unixEP);
                        Console.WriteLine("Connected");
                    }
                    var readerOpen = true;
                    var reader = Task.Run(() =>
                    {
                        while (true)
                        {
                            var buffer = new byte[1024];
                            var bufferSize = socket.Receive(buffer);
                            if (bufferSize <= 0) break;
                            Console.WriteLine(Encoding.UTF8.GetString(buffer, 0, bufferSize));
                        }
                        readerOpen = false;
                    });
                    var writer = Task.Run(async () =>
                    {
                        while (readerOpen)
                        {
                            socket.Send(Encoding.UTF8.GetBytes("Hello!"));
                            await Task.Delay(1000);
                        }
                    });
                    Task.WaitAll(reader, writer);
                    Console.WriteLine("Ending");
                }
                finally
                {
                    if (bind && File.Exists(socketPath))
                    {
                        File.Delete(socketPath);
                    }
                }
            }

            /*
            var unixSocket = "/var/run/mysqld/mysqld.sock";
            var socket = new Socket(AddressFamily.Unix, SocketType.Stream, ProtocolType.IP);
            var unixEp = new UnixEndPoint(unixSocket);
            socket.Connect(unixEp);
            */
            //RuntimeInformation.IsOSPlatform(    OSPlatform.Windows)
            //Environment.OSVersion.
            // var uep = new UnixEndPoint("");
            Console.WriteLine("Hello World!");
        }

        // https://stackoverflow.com/questions/38790802/determine-operating-system-in-net-core
        private static string GetUnixPipeName()
        {
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                return @"test.sock";
            }
            else if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                return @"test.sock";
            }
            else if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
            {
                throw new NotSupportedException();
            }
            else
            {
                throw new NotSupportedException();
            }
        }
    }
}
