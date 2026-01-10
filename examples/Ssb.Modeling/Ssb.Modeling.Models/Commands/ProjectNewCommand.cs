using Ssb.Modeling.Models.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace Ssb.Modeling.Models.Commands
{
    public class ProjectNewCommand : CommandBase
    {
        public ProjectNewCommand(Func<Task<bool>> act, Action<ProjectModel> set)
        {
            this.SetResult = set;
            this.New = act;
        }
        private Action<ProjectModel> SetResult { get; set; }
        private Func<Task<bool>> New { get; set; }

        protected override async void OnExecute(object parameter)
        {
            if (await this.New())
            {
                var result = ProjectProvider.New();
                this.SetResult(result);
            }
        }
    }
}
