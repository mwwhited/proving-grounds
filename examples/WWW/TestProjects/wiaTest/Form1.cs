using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WIA;

namespace wiaTest
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            CommonDialogClass class1 = new CommonDialogClass();
            Device d = class1.ShowSelectDevice(WiaDeviceType.UnspecifiedDeviceType, true, false);
            if (d != null)
            {
                var commands = d.Commands.OfType<DeviceCommand>().Select(m=>new {
                    Name=m.Name, 
                    Description=m.Description, 
                    CommandID=m.CommandID
                }).ToList();
                var events = d.Events.OfType<DeviceEvent>().Select(v => new {
                    Description = v.Description, 
                    EventID = v.EventID, 
                    Name = v.Name, 
                    Type = v.Type 
                }).ToList();
                var properties = d.Properties.OfType<Property>().Select(p => new
                {
                    IsReadOnly = p.IsReadOnly,
                    IsVector = p.IsVector,
                    Name = p.Name,
                    SubType = p.SubType,
                    Type = p.Type
                });
                //d.Items.OfType<Item>().Select(i=>new {
                //    i.
                //d.DeviceID = d.DeviceID;
                //d.Save();
            }
        }
    }
}
