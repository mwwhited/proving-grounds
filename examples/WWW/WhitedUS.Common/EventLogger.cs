using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO.IsolatedStorage;
using System.IO;

namespace WhitedUS.Common
{
    public class EventLogger
    {
        private const string LOG_FILE_NAME = "WhitedUS.Common.EventLog.log";
        public static void LogEvent(Exception e)
        {
            if (e == null)
                return;

            LogEvent(e.ToString());
        }

        public static void LogEvent(string message)
        {
            byte[] eventMessage = ASCIIEncoding.ASCII.GetBytes(string.Format(
                "================================\r\n" +
                "== {0} ==\r\n" +
                "{1}\r\n\r\n",
                DateTime.UtcNow,
                message
                ));

            lock (typeof(EventLogger))
            {
                var isoStore = IsolatedStorageFile.GetMachineStoreForDomain();
                using (var fs = new IsolatedStorageFileStream(
                    LOG_FILE_NAME,
                    FileMode.Append,
                    FileAccess.Write,
                    isoStore
                    ))
                {
                    fs.Write(eventMessage, 0, eventMessage.Length);
                    fs.Flush();
                }
            }
        }
    }
}
