using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OutOfBand.Cloud.Common
{
    [Serializable]
    public class StringArgs : EventArgs 
    {
        public StringArgs(string message)
        {
            this.Message = message;
        }

        private string _message;
        public string Message
        {
            get { return _message; }
            protected set { _message = value; }
        }
    }
}
