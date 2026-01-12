using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Web.Security;
using WhitedUS.Services.Configuration;

//http://support.microsoft.com/kb/231866
namespace WhitedUS.Services.Telnet
{
    public class TelnetService : IDisposable
    {
        public static void ServerStart()
        {
            var listener = new TcpListener(TelnetConfig.CurrentConfig.Port);
            listener.Start();

            while (true)
            {
                Console.WriteLine("Waiting on \"{0}\"", 
                                  listener.LocalEndpoint);
                Fork(listener.AcceptSocket());
            }
        }

        public static void Fork(Socket incomming)
        {
            new Thread(new ThreadStart(delegate
            {
                Console.WriteLine(incomming.RemoteEndPoint);
                Run(incomming);
                Thread.CurrentThread.Join();
            })).Start();
        }

        public static void Run(Socket incomming)
        {
            if (Login(incomming))
                new TelnetService(incomming).Runner();
            else
                incomming.Disconnect(true);
        }

        public static bool Login(Socket incomming)
        {
            if (!TelnetConfig.CurrentConfig.UseMembershipProvider)
                return true;

            byte[] welcomeMessage = Encoding.ASCII.GetBytes(string.Format(
                                "{0}\r\n", 
                                TelnetConfig.CurrentConfig.WelcomeMessage));

            byte[] loginMsg = Encoding.ASCII.GetBytes(string.Format(
                                "\n{0}", 
                                TelnetConfig.CurrentConfig.LoginPrompt));

            byte[] passwordMsg = Encoding.ASCII.GetBytes(string.Format(
                                "\n{0}", 
                                TelnetConfig.CurrentConfig.PasswordPrompt));

            byte[] failedMsg = Encoding.ASCII.GetBytes(string.Format(
                                "\n{0}", 
                                TelnetConfig.CurrentConfig.FailedMessage));

            byte[] dontEcho = new byte[] {
                //(byte)0,
                //(byte)TelnetCommands.IAC,
                (byte)TelnetCommands.IAC,
                //(byte)TelnetCommands.WONT,
                (byte)TelnetCommands.DONT,
                (byte)TelnetCommands.ECHO
                };

            byte[] doEcho = new byte[] {
                //(byte)0,
                //(byte)TelnetCommands.IAC,
                (byte)TelnetCommands.IAC,
                //(byte)TelnetCommands.WILL,
                (byte)TelnetCommands.DO,
                (byte)TelnetCommands.ECHO
                };

            byte[] buffer = new byte[1024];
            int bufferLen = 0;

            string userName = null;
            string password = null;

            Thread.CurrentThread.Name = string.Format(
                                                    "Login: {0} <=> {1}", 
                                                    incomming.LocalEndPoint, 
                                                    incomming.RemoteEndPoint);

            try
            {
                using (NetworkStream ns = new NetworkStream(incomming))
                {
                    ns.Write(welcomeMessage, 0, welcomeMessage.Length);
                    bufferLen = ns.Read(buffer, 0, buffer.Length);
                    for (int i = 0; i < 3; i++)
                    {
                        ns.Write(loginMsg, 0, loginMsg.Length);
                        bufferLen = ns.Read(buffer, 0, buffer.Length);
                        userName = Encoding.ASCII.GetString(buffer, 
                                                            0, 
                                                            bufferLen);
                        if (userName == "\r\n")
                            continue;
                        bufferLen = ns.Read(buffer, 0, buffer.Length);

                        ns.Write(passwordMsg, 0, passwordMsg.Length);
                        ns.Flush();
                        ns.Write(dontEcho, 0, dontEcho.Length);
                        ns.Flush();
                        bufferLen = ns.Read(buffer, 0, buffer.Length);
                        password = Encoding.ASCII.GetString(buffer, 
                                                            0, 
                                                            bufferLen);
                        if (password == "\r\n")
                            continue;
                        ns.Flush();
                        ns.Write(doEcho, 0, doEcho.Length);
                        ns.Flush();
                        bufferLen = ns.Read(buffer, 0, buffer.Length);

                        if (Membership.Provider.ValidateUser(userName, 
                                                             password))
                            return true;

                        ns.Write(failedMsg, 0, failedMsg.Length);
                        bufferLen = ns.Read(buffer, 0, buffer.Length);
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return false;
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

            on = new Thread(new ThreadStart(delegate { FromTo(string.Format(
                                                    "({0}) out->net", 
                                                    _socket.RemoteEndPoint),
                                                    output, 
                                                    net, 
                                                    ref _running); }));
            on.Start();
            _running++;
            en = new Thread(new ThreadStart(delegate { FromTo(string.Format(
                                                    "({0}) err->net", 
                                                    _socket.RemoteEndPoint), 
                                                    error, 
                                                    net, 
                                                    ref _running); }));
            en.Start();
            _running++;
            ni = new Thread(new ThreadStart(delegate { FromTo(string.Format(
                                                    "({0}) net->inp", 
                                                    _socket.RemoteEndPoint), 
                                                    net, 
                                                    input, 
                                                    ref _running); }));
            ni.Start();
            _running++;

            new Thread(new ThreadStart(delegate
            {
                while (_running == 3) { Thread.Sleep(10); }
                this.Dispose();
            })).Start();
        }

        private TelnetService(Socket socket)
        {
            _socket = socket;
            net = new NetworkStream(_socket);
        }

        private static void FromTo(string name, Stream from, 
                                   Stream to, ref int running)
        {
            Thread.CurrentThread.Name = string.Format("{0}: {1}=>{2}", 
                                                      name, 
                                                      from, 
                                                      to);
            byte[] buffer = new byte[1024];
            int bufferLen = 0;
            do
            {
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
                _socket.Disconnect(true);
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
