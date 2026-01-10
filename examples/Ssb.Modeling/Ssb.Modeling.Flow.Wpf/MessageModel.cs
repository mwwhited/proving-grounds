using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Ssb.Modeling.Flow.Wpf
{
    public class MessageModel : ViewModelBase
    {
        private string _sender;
        public string Sender
        {
            get { return this._sender; }
            set
            {
                this._sender = value;
                this.OnPropertyChanged();
            }
        }

        private string _receiver;
        public string Receiver
        {
            get { return this._receiver; }
            set
            {
                this._receiver = value;
                this.OnPropertyChanged();
            }
        }

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
