using System;
using System.Diagnostics.Contracts;
using System.Text;

namespace WhitedUS.Totp.Shared.Accessors
{
    public class DefaultCrypto : ICrypto
    {
        public byte[] Encrypt(byte[] data)
        {
            return Encoding.UTF8.GetBytes(Convert.ToBase64String(data));
        }

        public byte[] Decrpyt(byte[] data)
        {
            return Convert.FromBase64String(Encoding.UTF8.GetString(data, 0, data.Length));
        }
    }
}
