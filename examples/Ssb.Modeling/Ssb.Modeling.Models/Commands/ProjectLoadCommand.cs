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
    public class ProjectLoadCommand: CommandBase
    {
        public ProjectLoadCommand(Func<Task<XElement>> act, Action<ProjectModel> set)
        {
            if (act == null) throw new ArgumentNullException("act");
            if (set == null) throw new ArgumentNullException("set");

            this.SetResult = set;
            this.GetXml = act;
        }
        private Action<ProjectModel> SetResult { get; set; }
        private Func<Task<XElement>> GetXml { get; set; }

        protected override async void OnExecute(object parameter)
        {
            var xml = await this.GetXml();
            if (xml == null) return;

            var result = ProjectProvider.Parse(xml);
            this.SetResult(result);
        }
    }
}
