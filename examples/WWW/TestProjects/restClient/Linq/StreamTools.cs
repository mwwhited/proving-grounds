using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace restClient.Linq
{
    public static class StreamTools
    {
        public static void SaveTo(this Stream stream, string filename)
        {
            using (var file = File.Open(filename,
                                        FileMode.Create, 
                                        FileAccess.Write, 
                                        FileShare.None))
            {
                var buffer = new byte[1024 * 32];
                var bufferLen = 1;

                while (bufferLen > 0)
                {
                    bufferLen = stream.Read(buffer, 0, buffer.Length);
                    if (bufferLen > 0)
                        file.Write(buffer, 0, bufferLen);
                    file.Flush();
                }
            }
        }
    }
}
