using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

//WhitedUS.Libs.Security.Crypt.ICrypt,WhitedUS.Libs
namespace WhitedUS.Libs.Security.Crypt
{
    /// <summary>
    /// Interface to Identify supported Hash types
    /// </summary>
    public interface ICrypt
    {
        /// <summary>
        /// Prefix that identifies the Hash type
        /// </summary>
        byte[] Prefix { get; }

        /// <summary>
        /// Method to hash values
        /// </summary>
        /// <param name="key">key value</param>
        /// <param name="salt">salt value</param>
        /// <returns>computed has</returns>
        byte[] Crypt(byte[] key, byte[] salt);

        /// <summary>
        /// Minimum Salt Length
        /// </summary>
        int SaltMinLength { get; }

        /// <summary>
        /// Maximum Salt Length
        /// </summary>
        int SaltMaxLength { get; }

        /// <summary>
        /// Method to generate salt value
        /// </summary>
        /// <returns></returns>
        byte[] SaltGenerate();
    }
}
