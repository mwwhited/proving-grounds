using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Ports;
using System.Threading;
using System.Diagnostics;

namespace CommTest
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var sp = new SerialPort("COM1", 1200, Parity.None, 8, StopBits.One)
            {
                ReadTimeout = 30000,
                Handshake = Handshake.RequestToSend 
            })
            {
                var cr = new byte[] { 0x0d };

                var buffer = new byte[1024];
                int bufferLen=0;
                try
                {
                    sp.Open();
                    //sp.ReadTimeout = 100;

                    sp.Write(cr, 0, 1);
                    Thread.Sleep(10);
                    sp.Write(cr, 0, 1);

                    //int x = 0;


                    while (true)
                    {
                        //try
                        //{
                        //    sp.Write(new byte[] { DOSonChip.DOS_HANDSHAKE_POLL }, 0, 1);
                            bufferLen = sp.Read(buffer, 0, buffer.Length);
                            if (bufferLen == 1 && buffer[0] == DOSprotocol.DOS_HANDSHAKE_GO)
                                break;
                        //    Console.WriteLine(x++.ToString());
                        //    Thread.Sleep(100);
                        //}
                        //catch (Exception ex)
                        //{
                        //    Debug.WriteLine(ex.ToString());
                        //}
                    }

                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    Console.ReadLine();
                }
            }
        }
    }
}
