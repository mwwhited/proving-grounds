using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Ssb.Modeling.Flow.Wpf
{
    public class ServiceModel : ViewModelBase
    {
        private string _name;
        public string Name
        {
            get { return this._name; }
            set
            {
                this._name = value;
                this.OnPropertyChanged();
            }
        }
    }
}
