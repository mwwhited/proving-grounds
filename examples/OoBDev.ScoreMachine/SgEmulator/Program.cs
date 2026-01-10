using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SgEmulator
{
    class Program
    {
        static void Main(string[] args)
        {
            //COM4

            var temp = 0;

            Task.WaitAny(
                Task.Run(() =>
                {
                    using (var serialPort = new SerialPort("COM4", 9600))
                    {
                        serialPort.Open();

                        foreach (var f in GetFrame())
                        {
                            var str = Encoding.ASCII.GetString(f, 0, f.Length);
                            serialPort.BaseStream.Write(f, 0, f.Length);
                            serialPort.BaseStream.Flush();
                            Console.WriteLine(string.Join("\t", str, f.Length, string.Join("", f.Select(i => i.ToString("x2")))));
                            Thread.Sleep(temp);
                        }
                    }
                }),
                Task.Run(() =>
                {
                    while (Continue(out var key))
                    {
                        switch (key.Key)
                        {
                            case ConsoleKey.UpArrow:
                                temp += 10;
                                break;
                            case ConsoleKey.DownArrow:
                                temp -= 10;
                                break;
                        }

                        if (temp <= 0)
                        {
                            temp = 0;
                        }
                        else if (temp >= 1000)
                        {
                            temp = 1000;
                        }
                        Debug.WriteLine(temp);
                    }
                })
            );
        }

        public static bool Continue(out ConsoleKeyInfo consoleKey)
        {
            return (consoleKey = Console.ReadKey(true)).Key != ConsoleKey.Escape;
        }

        public static IEnumerable<byte[]> GetFrame()
        {
            while (true)
            {
                var data = File.ReadAllBytes("outfile.bin");
                var buffer = new List<byte>();
                foreach (var b in data)
                {
                    buffer.Add(b);
                    if (b == 0x04)
                    {
                        yield return buffer.ToArray();
                        buffer.Clear();
                    }
                }
                if (buffer.Count > 0)
                {
                    yield return buffer.ToArray();
                }
            }
        }
    }
}
