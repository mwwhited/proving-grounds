using System;
using System.Collections.Generic;
using System.Text;

namespace OsciRenderClient
{
    internal class Program
    {
        public static void Main()
        {
            using var client = new OsciRenderClient();
            client.Connect();

            var frame = new OsciFrame
            {
                FocalLength = -0.05 * 50, // 50mm lens equivalent                 
                Objects =
                        {
                            new OsciObject
                            {
                                Strokes =
                                {
                                    new OsciStroke
                                    {
                                        Vertices =
                                        {
                                            (0.0,  0.5, 0.0),
                                            (0.5, -0.5, 0.0),
                                            (-0.5,-0.5, 0.0),
                                            (0.0,  0.5, 0.0), // close the loop
                                        }
                                    }
                                }
                            }
                        }
            };

            while (true)
            {
                client.SendFrame(frame, fps: 30);
                Thread.Sleep((int)(30f/1000f));
                Console.WriteLine(".");
            }
        }
    }
}
