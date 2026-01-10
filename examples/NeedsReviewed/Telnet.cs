using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.Threading;
using System.Diagnostics;
using System.IO;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            TcpListener listener = new TcpListener(23);
            listener.Start();

            while (true)
            {
                Console.WriteLine("Waiting on \"{0}\"", listener.LocalEndpoint);
                SpinUp(listener.AcceptSocket());
            }
        }

        static void SpinUp(Socket incomming)
        {
            new Thread(new ThreadStart(delegate
            {
                Console.WriteLine(incomming.RemoteEndPoint);
                SocketRunner.Run(incomming);
                Thread.CurrentThread.Join();
            })).Start();
        }
    }

    public class SocketRunner : IDisposable
    {
        public static void Run(Socket incomming)
        {
            new SocketRunner(incomming).Runner();
        }

        Socket _socket = null;
        Process process = new Process();
        NetworkStream net = null;
        int _running = 0;
        Thread on = null;
        Thread en = null;
        Thread ni = null;

        private void Runner()
        {
            ProcessStartInfo psi = new ProcessStartInfo("cmd.exe");
            psi.CreateNoWindow = true;
            psi.RedirectStandardError = true;
            psi.RedirectStandardInput = true;
            psi.RedirectStandardOutput = true;
            psi.StandardErrorEncoding = Encoding.ASCII;
            psi.StandardOutputEncoding = Encoding.ASCII;
            psi.WorkingDirectory = @"c:\";
            psi.UseShellExecute = false;

            //============

            process.StartInfo = psi;
            process.Start();

            Stream output = process.StandardOutput.BaseStream; // => reader
            Stream input = process.StandardInput.BaseStream; // => writer
            Stream error = process.StandardError.BaseStream; // => reader

            on = new Thread(new ThreadStart(delegate { FromTo(string.Format("({0}) out->net", _socket.RemoteEndPoint), output, net, ref _running); }));
            on.Start();
            _running++;
            en = new Thread(new ThreadStart(delegate { FromTo(string.Format("({0}) err->net", _socket.RemoteEndPoint), error, net, ref _running); }));
            en.Start();
            _running++;
            ni = new Thread(new ThreadStart(delegate { FromTo(string.Format("({0}) net->inp", _socket.RemoteEndPoint), net, input, ref _running); }));
            ni.Start();
            _running++;

            new Thread(new ThreadStart(delegate
            {
                while (_running == 3) { Thread.Sleep(10); }
                this.Dispose();
            })).Start();
        }

        private SocketRunner(Socket socket)
        {
            _socket = socket;
            net = new NetworkStream(_socket);
        }

        private static void FromTo(string name, Stream from, Stream to, ref int running)
        {
            Thread.CurrentThread.Name = string.Format("{0}: {1}=>{2}", name, from, to);
            //Console.WriteLine("Starting: {0}", Thread.CurrentThread.Name);
            byte[] buffer = new byte[1024];
            int bufferLen = 0;
            do
            {
                //Console.WriteLine(Thread.CurrentThread.Name);
                bufferLen = from.Read(buffer, 0, buffer.Length);
                if (bufferLen > 0)
                {
                    to.Write(buffer, 0, bufferLen);
                    to.Flush();
                }
            } while (bufferLen > 0);

            from.Flush();
            from.Close();
            from.Dispose();

            to.Flush();
            to.Close();
            to.Dispose();

            running--;

            //Console.WriteLine("Ending: {0}", Thread.CurrentThread.Name);
            Thread.CurrentThread.Join();

        }

        private static void KillThread(ref Thread thread)
        {
            if (thread != null &&
                (thread.ThreadState != System.Threading.ThreadState.Stopped &&
                thread.ThreadState != System.Threading.ThreadState.Aborted
                ))
            {
                try { thread.Abort(); }
                catch { }
                thread = null;
            }
        }

        #region IDisposable Members

        public void Dispose()
        {
            KillThread(ref on);
            KillThread(ref en);
            KillThread(ref ni);

            if (net != null)
            {
                net.Flush();
                net.Close();
                net.Dispose();
                net = null;
            }

            if (_socket != null)
            {
                _socket.Close();
                _socket = null;
            }

            if (process != null)
            {
                process.Close();
                process.Dispose();
                process = null;
            }
        }

        #endregion
    }
}
