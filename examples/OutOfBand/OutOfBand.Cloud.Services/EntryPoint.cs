using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading;
using OutOfBand.Cloud.Configuration;
using OutOfBand.Cloud.Definitions;
using OutOfBand.Cloud.Common;

namespace OutOfBand.Cloud.Services
{
    public class EntryPoint : MarshalByRefObject, IService
    {
        private Guid _instanceId = Guid.NewGuid();
        private int _boundEvents = 0;
        private bool _isBound = false;

        public Guid InstanceId { get { return _instanceId; } }

        public void OnFromService(object sender, EventArgs e)
        {
            if (this._fromService != null)
                this._fromService(this, e);
        }

        private event EventHandler _fromService;
        public event EventHandler FromService
        {
            add
            {
                var channel = this.Instance as IChannel;
                if (channel != null)
                {
                    _fromService += value;
                    _boundEvents++;
                    if (!_isBound)
                    {
                        channel.FromService += new EventHandler(OnFromService);
                        _isBound = true;
                    }
                }
            }
            remove
            {
                var channel = this.Instance as IChannel;
                if (channel != null)
                {
                    _fromService -= value;
                    _boundEvents--;
                    if (_boundEvents <= 0)
                    {
                        _boundEvents = 0;
                        channel.FromService -= new EventHandler(OnFromService);
                        _isBound = false;
                    }
                }
            }
        }

        internal EntryPoint()
        {
        }

        internal EntryPoint(string serviceType)
            : this(new ServiceConfig()
                {
                    TypeName = serviceType
                })
        {
        }

        internal EntryPoint(ServiceConfig config)
            : this()
        {
            this.Config = config;
        }

        public AppDomain Domain
        {
            get
            {
                return AppDomain.CurrentDomain;
            }
        }

        public ServiceConfig Config { get; set; }

        private IApplication _instance;
        protected IApplication Instance
        {
            get
            {
                if (_instance == null)
                    _instance = this.Config.CreateInstance();
                return _instance;
            }
            private set
            {
                _instance = value;
            }
        }

        private Thread _thread = null;

        public static EntryPoint CreateIsolated(ServiceConfig config)
        {
            var newDomain = AppDomain.CreateDomain("EntryPoint " +
                                                   config.Type.Name);

            var entryPointType = typeof(EntryPoint);
            var assemblyName = entryPointType.Assembly.FullName;
            var typeName = entryPointType.FullName;
            var obj = newDomain.CreateInstanceAndUnwrap(assemblyName,
                                                        typeName);
            var ret = obj as EntryPoint;
            ret.Config = config;
            return ret;
        }

        public static EntryPoint Load(Package package)
        {
            if (package == null)
                throw new ArgumentNullException("package");

            var entryPoint = EntryPoint.CreateIsolated(package.Config);

            if (package.State != null)
                entryPoint.Restore(package.State);
            else
                entryPoint.Start();

            return entryPoint;
        }

        public static Package Unload(EntryPoint entryPoint)
        {
            if (entryPoint == null)
                throw new ArgumentNullException("entryPoint");

            var package = new Package()
            {
                Config = entryPoint.Config,
                State = entryPoint.Persist()
            };

            if (entryPoint.Domain != AppDomain.CurrentDomain)
                AppDomain.Unload(entryPoint.Domain);

            return package;
        }

        public void PersistTo(Stream stream)
        {
            var state = this.Persist();
            var formatter = new BinaryFormatter();
            formatter.Serialize(stream, state);
        }

        public object Persist()
        {
            return this.Instance.Persist();
        }

        public void RestoreFrom(Stream stream)
        {
            if (this._thread == null)
            {
                var formatter = new BinaryFormatter();
                var obj = formatter.Deserialize(stream);
                this.Restore(obj);
            }
        }
        public void Restore(object state)
        {
            if (this._thread == null)
            {
                this._thread = new Thread(() =>
                {
                    this.Instance.Restore(state);
                }
                );
                this._thread.Start();
            }
        }

        #region IService Members

        public void Start()
        {
            if (this._thread == null)
            {
                _thread = new Thread(this.Instance.Start);
                _thread.Start();
            }
        }

        public void Stop()
        {
            if (this._thread != null)
            {
                this.Instance.Stop();
                _thread.Join();
                _thread = null;
            }
        }

        #endregion

        public void ToService(object message)
        {
            var channel = this.Instance as IChannel;
            if (channel != null)
                channel.ToService(message);
        }
    }
}
