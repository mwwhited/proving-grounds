using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Ssb.Modeling.Wpf.Dialogs
{
    public class SaveProject
    {
        public static Task SaveXml(XElement xml)
        {
            return Task.Run(() =>
            {
                var odf = new SaveFileDialog()
                {
                    Filter = DialogGlobals.ProjectFileFilter,
                    AddExtension = true,
                    CheckFileExists = false,
                    FilterIndex = 0,
                    Title = "Save Project",
                };

                if (odf.ShowDialog() ?? false)
                {
                    using (var file = odf.OpenFile())
                    {
                        xml.Save(file);
                    }
                }
            });
        }
    }
}
