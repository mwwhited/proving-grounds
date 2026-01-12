using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OutOfBand.Cloud.TestServices
{
    [Serializable]
    public class MyState
    {
        private bool _running;
        public bool Running
        {
            get { return _running; }
            set { _running = true; }
        }

        private int _state;
        public int State
        {
            get { return _state; }
            set { _state = value; }
        }
    }
}
