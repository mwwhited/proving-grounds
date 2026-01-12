using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using OutOfBand.Cloud.Definitions;
using OutOfBand.Cloud.Common;

namespace OutOfBand.Cloud.TestServices
{
    public class MyService : IApplication<MyState>, IChannel<string>
    {
        public MyService()
        {
        }

        private static int _idCnt = 0;
        private int _id = _idCnt++;

        private volatile bool _running = false;
        private volatile int _state = 0;

        #region IService Members

        public void Start()
        {
            _running = true;
            Worker();
        }

        private void Worker()
        {
            while (_running)
            {
                if (this.FromService != null)
                    if (_state % 3 == 0)
                        this.FromService(this, new StringArgs(_state.ToString()));
                Console.WriteLine("{0} - {1} => {2}",
                                  _id,
                                  _state++,
                                  AppDomain.CurrentDomain.FriendlyName);
                Thread.Sleep(100);
            }
        }

        public void Stop()
        {
            _running = false;
        }

        #endregion

        #region IApplication<MyState> Members

        public MyState Persist()
        {
            var ret = new MyState()
            {
                Running = _running,
                State = _state
            };
            this.Stop();
            return ret;
        }

        public void Restore(MyState state)
        {
            _running = state.Running;
            _state = state.State;
            this.Worker();
        }

        #endregion

        #region IApplication Members

        object IApplication.Persist()
        {
            return this.Persist();
        }

        public void Restore(object state)
        {
            this.Restore(state as MyState);
        }

        #endregion

        #region IChannel<string> Members

        public void ToService(string message)
        {
            Console.WriteLine("{0} -> {1}", DateTime.Now, message);
        }

        #endregion

        #region IChannel Members

        public event EventHandler FromService;

        public void ToService(object message)
        {
            this.ToService(message as string);
        }

        #endregion
    }
}
