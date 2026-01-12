using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.

namespace OutOfBand.Cloud.Services
{
    public class Node
    {
        public AppDomain AppDomain
        {
            get
            {
                return AppDomain.CurrentDomain;
            }
        }

        public 

        private Dictionary<Guid, EntryPoint> _entryPoints =
                                            new Dictionary<Guid, EntryPoint>();

        public EntryPoint this[Guid entryPointId]
        {
            get
            {
                if (!_entryPoints.ContainsKey(entryPointId))
                    return null;
                return _entryPoints[entryPointId];
            }
            protected set
            {
                if (_entryPoints.ContainsKey(entryPointId))
                    _entryPoints[entryPointId] = value;
                else
                    _entryPoints.Add(entryPointId, value);
            }
        }

        public void Add(EntryPoint entryPoint)
        {
            if (entryPoint == null)
                throw new ArgumentNullException("entryPoint");

            this[entryPoint.InstanceId] = entryPoint;
        }

        public IEnumerable<EntryPoint> Current
        {
            get { return _entryPoints.Values.Select(s => s); }
        }
    }
}
