using Ssb.Modeling.Models.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Xml.Linq;

namespace Ssb.Modeling.Models.Commands
{
    public class ProjectSaveCommand : CommandBase
    {
        public ProjectSaveCommand(Func<ProjectModel> get, Func<XElement, Task> act)
        {
            this.GetModel = get;
            this.SaveXml = act;
        }
        private Func<ProjectModel> GetModel { get; set; }
        private Func<XElement, Task> SaveXml { get; set; }

        protected override async void OnExecute(object parameter)
        {
            var model = this.GetModel();
            var result = ProjectProvider.ToXml(model);
            await this.SaveXml(result);
        }
    }
}
