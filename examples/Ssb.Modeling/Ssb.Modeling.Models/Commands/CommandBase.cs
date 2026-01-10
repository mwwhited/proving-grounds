using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace Ssb.Modeling.Models.Commands
{
    public abstract class CommandBase : ICommand
    {
        private bool _isEnabled = true;
        public bool IsEnabled
        {
            get { return this._isEnabled; }
            set
            {
                this._isEnabled = value;
                if (this.CanExecuteChanged != null)
                    this.CanExecuteChanged(this, new EventArgs { });
            }
        }

        public virtual bool CanExecute(object parameter)
        {
            return this.IsEnabled;
        }

        public event EventHandler CanExecuteChanged;

        protected abstract void OnExecute(object parameter);
        
        public void Execute(object parameter)
        {
            this.OnExecute(parameter);
        }
    }
}
