using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Security.Crypt
{
    /// <summary>
    /// Support for Apache MD5 hashes
    /// </summary>
    public class ApacheMd5Crypt : Md5Crypt
    {
        private readonly static byte[] _prefix = 
            Encoding.ASCII.GetBytes("$apr1$");

        /// <summary>
        /// byte[] of "$apr1$"
        /// </summary>
        public override byte[] Prefix { get { return _prefix; } }
    }
}
