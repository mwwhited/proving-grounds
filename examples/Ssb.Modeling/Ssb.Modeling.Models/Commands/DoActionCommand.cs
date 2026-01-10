using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Commands
{
    public class DoActionCommand : CommandBase
    {
        public DoActionCommand(Action<object> action)
        {
            this.Action = action;
        }
        private Action<object> Action { get; set; }

        protected override void OnExecute(object parameter)
        {
            if (this.Action != null)
                this.Action(parameter);
        }
    }
}
