using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Principal;

namespace WhitedUS.Security
{
    public class MyAccessControlEntry
    {
        private IMyResource _resource;
        private IMyIdentity _identity;
        private MyAccessLevelFlag _accessLevel;
        private MyAccessRightFlag _accessRight;

        public MyAccessControlEntry(IMyResource resource, 
                                    IMyIdentity identity, 
                                    MyAccessLevelFlag accessLevel, 
                                    MyAccessRightFlag accessRight)
        {
            _resource = resource;
            _identity = identity;
            _accessLevel = accessLevel;
            _accessRight = accessRight;
        }

        public IMyResource Resource { get { return _resource; } }
        public IMyIdentity Identity { get { return _identity; } }
        public MyAccessLevelFlag AccessLevel { get { return _accessLevel; } }
        public MyAccessRightFlag AccessRight { get { return _accessRight; } }
    }
}
