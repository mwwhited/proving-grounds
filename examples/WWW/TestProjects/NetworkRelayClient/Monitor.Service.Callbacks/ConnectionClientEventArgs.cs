using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Monitor.Service.Callbacks
{
    public class ConnectionClientEventArgs : EventArgs
    {
        private string _originSocketName = null;

        public ConnectionClientEventArgs(string originSocketName)
        {
            _originSocketName = originSocketName;
        }

        public string OriginSocketName { get { return _originSocketName; } }
    }
}
