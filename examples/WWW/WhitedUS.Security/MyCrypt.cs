using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Libs.Security.Crypt;

//WhitedUS.Security.MyCrypt,WhitedUS.Security
namespace WhitedUS.Security
{
    /// <summary>
    /// Support for MyCrypt MD5 hashes
    /// </summary>
    public class MyCrypt : Md5Crypt
    {
        private readonly static byte[] _prefix = 
                                        Encoding.ASCII.GetBytes("$myCrypt1$");

        /// <summary>
        /// byte[] of "$apr1$"
        /// </summary>
        public override byte[] Prefix { get { return _prefix; } }
    }
}
