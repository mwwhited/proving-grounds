using System;
using System.Collections.Generic;
using System.Linq;
using System.Management;
using System.Text;
using System.Threading.Tasks;

namespace UsbEnumerator
{
    class Program
    {
        static void Main(string[] args)
        {
            var searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_USBControllerdevice");
            //var searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM CIM_USBDevice");
            foreach (var queryObj in searcher.Get())
            {
                Console.WriteLine("+++ Device +++");
                //Console.WriteLine("\t{0}: {1}", "Description", queryObj["Description"]);
                //Console.WriteLine("\t{0}: {1}", "CreationClassName", queryObj["CreationClassName"]);
                //Console.WriteLine("\t{0}: {1}", "DeviceID", queryObj["DeviceID"]);

                foreach (var prop in queryObj.Properties)
                {
                    if (prop.Value == null)
                        continue;

                    if (prop.Value.ToString().Contains("0200"))
                        Console.WriteLine(">>>");
                    Console.WriteLine("\t{0}: {1}", prop.Name, prop.Value);

                    // \\MONSTER\root\cimv2:Win32_USBController.DeviceID="PCI\\VEN_1002&DEV_4396&SUBSYS_43961849&REV_00\\3&267A616A&2&9A"                    
                }

                Console.WriteLine();

                //Caption: USB Composite Device
                //ConfigManagerErrorCode: 0
                //ConfigManagerUserConfig: False
                //CreationClassName: Win32_USBHub
                //Description: USB Composite Device
                //DeviceID: USB\VID_047F&PID_C008\6&39BE2762&0&01
                //Name: USB Composite Device
                //PNPDeviceID: USB\VID_047F&PID_C008\6&39BE2762&0&01
                //Status: OK
                //SystemCreationClassName: Win32_ComputerSystem
                //SystemName: MONSTER
            }

            Console.Read();
        }
    }
}
