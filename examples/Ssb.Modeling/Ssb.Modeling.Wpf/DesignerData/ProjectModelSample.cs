using Ssb.Modeling.Models;
using Ssb.Modeling.Models.Providers;
using Ssb.Modeling.Wpf.Providers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xaml;
using System.Xml.Linq;

namespace Ssb.Modeling.Wpf.DesignerData
{
    public static class ProjectModelSample
    {
        private readonly static IEnumerable<ProjectModel> _designerDataSet = new[] { ProjectModelSample.Factory() };
        private readonly static ProjectModel _designerData = ProjectModelSample.Factory();
        public static ProjectModel DesignerData
        {
            get { return ProjectModelSample._designerData; }
        }

        public static IEnumerable<ProjectModel> DesignerDataSet
        {
            get { return ProjectModelSample._designerDataSet; }
        }

        private static ProjectModel Factory()
        {
            var resourceLoader = new ResourceLoader();
            Stream sampleStream = null;
            resourceLoader.GetResource("Ssb.Modeling.Models.Scripts.ProjectExportSample.cgx")
                          .ContinueWith(t => sampleStream = t.Result)
                          .Wait();
            if (sampleStream != null)
                using (sampleStream)
                {
                    var sampleXml = XElement.Load(sampleStream);
                    var model = ProjectProvider.Parse(sampleXml);
                    return model;
                }
            return null;
        }

        public static string AsXaml()
        {
            var model = ProjectModelSample.Factory();
            var result = XamlServices.Save(model);
            return result;
        }
    }
}
