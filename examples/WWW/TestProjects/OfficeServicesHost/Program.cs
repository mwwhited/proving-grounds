using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Threading;
using WhitedUS.ServiceModel;
using WhitedUS.ServiceModel.Office;
using WhitedUS.Services;
using WhitedUS.Services.SNTP;
using System.Diagnostics;
using WhitedUS.ServiceModel.Services;

namespace OfficeServicesHost
{
    class Program
    {
        static Dictionary<string, ServiceHost> loadedServices = new Dictionary<string, ServiceHost>();
        static bool StartRestfulServer<T>() where T : class
        {
            bool ret = false;
            var serviceName = typeof(T).Name;
            try
            {
                Console.WriteLine(serviceName + " loading");
                WebServiceHost service = WebServiceHostFactory.Create<T>();
                Console.WriteLine(serviceName + " opening");
                service.Open();
                Console.WriteLine(serviceName + " loaded");
                var uri = service.BaseAddresses.First().AbsoluteUri;
                Console.WriteLine(uri);
                loadedServices.Add(serviceName, service);
                ret = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(serviceName + " exception");
                Console.WriteLine(ex.Message);
            }
            Console.WriteLine();
            return ret;
        }

        static ManualResetEvent mre = new ManualResetEvent(false);
        static void Main(string[] args)
        {
            AppDomain.CurrentDomain.ProcessExit += new EventHandler(CurrentDomain_ProcessExit);
            bool somethingStarted = false;

            somethingStarted |= StartRestfulServer<OutlookServices>();
            somethingStarted |= StartRestfulServer<MediaRest>();
            somethingStarted |= StartRestfulServer<BlogSitemap>();
            try
            {
                Console.WriteLine("Stop W32Time Service");
                Process.Start(new ProcessStartInfo("net.exe")
                {
                    Arguments = "stop W32Time",
                    CreateNoWindow = false
                }).WaitForExit(30000);
                Console.WriteLine("SNTPService starting");
                SNTPService.ServerStart();
                Console.WriteLine("SNTPService started");
                somethingStarted = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("SNTPService exception");
                Console.WriteLine(ex.Message);
            }
            Console.WriteLine();
            if (somethingStarted)
            {
                Console.WriteLine("One or more services has loaded");
                //mre.WaitOne();

                while (true)
                {
                    Console.Write(">");
                    var cmd = Console.ReadLine().ToLower();
                    switch (cmd)
                    {
                        case"":
                            Console.WriteLine();
                            break;
                        case "list":
                            Console.WriteLine(string.Join("\r\n", loadedServices.Select(kvp => kvp.Key + " - " + kvp.Value.BaseAddresses.First().AbsoluteUri).ToArray()));
                            break;

                        case "exit":
                            Console.WriteLine("Good Bye!!!");
                            goto killservices;

                        case "help":
                        case "?":
                            Console.WriteLine();
                            Console.WriteLine("help | ? - show this menu");
                            Console.WriteLine("exit     - unload services and exit");
                            Console.WriteLine("list     - list running \"RESTful\" services");
                            Console.WriteLine();
                            break;

                        default:
                            Console.WriteLine(string.Format("Command \"{0}\" not found", cmd));
                            break;
                    }
                }

            killservices:
                foreach (var item in loadedServices)
                {
                    try
                    {
                        Console.WriteLine("Close " + item.Key);
                        item.Value.Close();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                    
                }
                SNTPService.Kill();
            }
            else
            {
                Console.WriteLine("Nothing loaded");
                Console.WriteLine("Press Enter to Exit");
                Console.ReadLine();
            }
        }

        static void CurrentDomain_ProcessExit(object sender, EventArgs e)
        {
            mre.Set();
            Console.WriteLine("Start W32Time Service");
            Process.Start(new ProcessStartInfo("net.exe")
            {
                Arguments = "start W32Time",
                CreateNoWindow = false
            }).WaitForExit();
        }
    }
}
