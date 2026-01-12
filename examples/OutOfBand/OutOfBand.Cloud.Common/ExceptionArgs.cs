using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OutOfBand.Cloud.Common
{
    [Serializable]
    public class ExceptionArgs : EventArgs
    {
        public ExceptionArgs(Exception exception)
        {
            this.Exception = exception;
        }

        private Exception _exception;
        public Exception Exception
        {
            get { return _exception; }
            protected set
            {
                _exception = value;
            }

        }
    }
}
