using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Ssb.Modeling.Wpf.Dialogs
{
    public class LoadProject
    {
        public static Task<XElement> LoadXml()
        {
            return Task.Run(() =>
            {
                var odf = new OpenFileDialog()
                {
                    Filter = DialogGlobals.ProjectFileFilter,
                    AddExtension = true,
                    CheckFileExists = true,
                    Multiselect = false,
                    FilterIndex = 0,
                    Title = "Load Project",
                };

                if (odf.ShowDialog() ?? false)
                {
                    using (var file = odf.OpenFile())
                    {
                        return XElement.Load(file);
                    }
                }

                return null;
            });
        }
    }
}
