using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Management;
using System.Text;
using System.Threading.Tasks;

namespace UsbMonitor
{
    class Program
    {
        // http://dotnetslackers.com/Community/blogs/basharkokash/archive/2008/02/06/usb-port-insert-remove-detection-using-wmi.aspx
        static void Main(string[] args)
        {
            var handler = Task.Run(() => AddUSBHandler());
            Console.WriteLine("Waiting!");
            Console.Read();
            handler.Wait();
        }

        //used to subscribes to temporary event notifications based on a specified event query.
        private static ManagementEventWatcher w = null;

        private static void AddUSBHandler()
        {
            WqlEventQuery q;// Represents a WMI event query in WQL format (Windows Query Language)

            var scope = new ManagementScope("root\\CIMV2");

            // Represents a scope (namespace) for management operations.

            scope.Options.EnablePrivileges = true;
            try
            {

                // So we have to add two events to the same record and these events are "__InstanceCreationEvent" for insertion and "__InstanceDeletionEvent"  for removal.

                q = new WqlEventQuery();
                q.EventClassName = "__InstanceCreationEvent";
                q.WithinInterval = new TimeSpan(0, 0, 3);
                q.Condition = @"TargetInstance ISA 'Win32_USBControllerdevice'";
                w = new ManagementEventWatcher(scope, q);

                //adds event handler that’s is fired when the insertion event occurs
                w.EventArrived += (s, e) =>
                {
                    try
                    {
                        //Name	"TargetInstance"	string
                        var prop = e.NewEvent.Properties.OfType<PropertyData>().FirstOrDefault(p => p.Name == "TargetInstance");
                        var obj = prop.Value as ManagementBaseObject;
                        var props = obj.Properties.OfType<PropertyData>().ToDictionary(k => k.Name, k => k.Value);
                        var quas = obj.Qualifiers.OfType<QualifierData>().ToDictionary(k => k.Name, k => k.Value);
                        var sysProps = obj.SystemProperties.OfType<PropertyData>().ToDictionary(k => k.Name, k => k.Value);

                        var usb = new
                        {
                            Dependent = props["Dependent"],
                            Antecedent = props["Antecedent"],
                            UUID = quas["UUID"],
                            __PATH = sysProps["__PATH"],
                            __RELPATH = sysProps["__RELPATH"],
                        };

                        Console.WriteLine("USB device is inserted at {0} => {1}", DateTime.Now, usb);
                        File.AppendAllText("usb.txt", string.Format("USB device is inserted at {0} => {1}", DateTime.Now, usb) + Environment.NewLine);
                    }
                    catch (Exception ex)
                    {
                        Console.Error.WriteLine("OOPZ: {0}", ex.Message);
                    }
                };

                w.Start(); //run the watcher
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("OOPS: {0}", e.Message);
                if (w != null)
                    w.Stop();
            }
        }
    }
}
