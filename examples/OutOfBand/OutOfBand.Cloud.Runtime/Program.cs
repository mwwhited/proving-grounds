using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using OutOfBand.Cloud.Common;
using OutOfBand.Cloud.Common.Linq;
using OutOfBand.Cloud.Common.Xml.Linq;
using OutOfBand.Cloud.Configuration;
using OutOfBand.Cloud.Services;
using OutOfBand.Cloud.TestServices;

namespace OutOfBand.Cloud.Runtime
{
    class Program
    {
        static void Main(string[] args)
        {
            var serviceType = typeof(MyService);
            var serviceConfig = new ServiceConfig()
            {
                Type = serviceType
            };
            serviceConfig.SaveXmlTo("serviceConfig.xml");

            var ep = EntryPoint.CreateIsolated(serviceConfig);
            ep.Start();
            Thread.Sleep(1000);

            var package =  EntryPoint.Unload(ep);

            package.SaveObjectTo("persist.bin");
            package.SaveXmlTo("persist.xml");

            //package = "persist.xml".LoadXmlAs<Package>();
            package = "persist.bin".LoadObjectAs<Package>();

            Thread.Sleep(1000);

            var ep2 = EntryPoint.Load(package);

            Thread.Sleep(1000);

            ep2.Stop();

            //var entryPoint = new EntryPoint(serviceConfig);
            //entryPoint.Start();

            //Thread.Sleep(2000);
            //var ms = new MemoryStream();
            //entryPoint.PersistTo(ms);
            //ms.Seek(0, SeekOrigin.Begin);

            //var ep3 = new EntryPoint(serviceConfig);
            //ep3.Start();

            //var ep2 = EntryPoint.CreateIsolated(serviceConfig);
            //ep2.FromService += new EventHandler(ep2_FromService);

            //ep2.Start();

            //Thread.Sleep(1000);

            //var ms2 = new MemoryStream();
            //ep2.PersistTo(ms2);
            //ms2.Seek(0, SeekOrigin.Begin);

            //entryPoint.Stop();
            //Thread.Sleep(1000);
            //ep2.Stop();

            //Thread.Sleep(200);
            //ep3.Stop();

            //var newEp = new EntryPoint(serviceConfig);
            //newEp.RestoreFrom(ms);
            //var newEp2 = EntryPoint.CreateIsolated(serviceConfig);
            //newEp2.RestoreFrom(ms2);

            //ms2.Seek(0, SeekOrigin.Begin);
            //var newEp3 = new EntryPoint(serviceConfig);
            //newEp3.RestoreFrom(ms2);

            //Thread.Sleep(1000);
            //newEp.Stop();
            //Thread.Sleep(500);
            //newEp2.Stop();
            //Thread.Sleep(1000);
            //newEp3.Stop();

            Console.WriteLine("press enter to exit");
            Console.Read();
        }

        static void ep2_FromService(object sender, EventArgs e)
        {
            var entryPoint = sender as EntryPoint;
            if (entryPoint != null)
            {
                var message = e as StringArgs;
                if (message != null)
                {
                    entryPoint.ToService(string.Format("You Said: {0}",
                                                       message.Message));
                }
            }
        }
    }
}
