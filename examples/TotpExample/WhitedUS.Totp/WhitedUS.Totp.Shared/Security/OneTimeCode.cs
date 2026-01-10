using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WhitedUS.Totp.Shared.Converters;

namespace WhitedUS.Totp.Shared.Security
{
    public class OneTimeCode
    {
        public static readonly DateTime UNIX_EPOCH = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
        public long GetCurrentCounter()
        {
            var counter = (long)(DateTime.UtcNow - OneTimeCode.UNIX_EPOCH).TotalSeconds / 30;
            return counter;
        }

        public string GenerateToken(string secret, long iterationNumber, int digits = 6)
        {
            var counter = BitConverter.GetBytes(iterationNumber);

            if (BitConverter.IsLittleEndian)
                Array.Reverse(counter);

            var key = this.GetKey(secret);

            var hash = EncryptionTools.HMACSHA1(key, counter);

            var offset = hash[hash.Length - 1] & 0xf;

            var binary =
                ((hash[offset] & 0x7f) << 24)
                | ((hash[offset + 1] & 0xff) << 16)
                | ((hash[offset + 2] & 0xff) << 8)
                | (hash[offset + 3] & 0xff);

            var password = binary % (int)Math.Pow(10, digits); // 6 digits

            var result = password.ToString(new string('0', digits));

            return result;
        }

        public string GetToken(string secret, long? counter = null)
        {
            return this.GenerateToken(secret, counter ?? this.GetCurrentCounter());
        }

        public bool IsValid(string secret, string token, int checkAdjacentIntervals = 1)
        {
            if (token == this.GetToken(secret))
                return true;

            for (int i = 1; i <= checkAdjacentIntervals; i++)
            {
                if (token == this.GetToken(secret, this.GetCurrentCounter() + i))
                {
                    return true;
                }
                if (token == this.GetToken(secret, this.GetCurrentCounter() - i))
                {
                    return true;
                }
            }
            return false;
        }

        public string GenerateSecret()
        {
            var buffer = EncryptionTools.GenerateSecret(9);
            var secret = Convert.ToBase64String(buffer).Substring(0, 10).Replace('/', '0').Replace('+', '1');
            var encoded = Base32Encoding.ToString(Encoding.UTF8.GetBytes(secret));
            return encoded;
        }
        
        public byte[] GetKey(string secret)
        {
            var decoded = Base32Encoding.ToBytes(secret);
            return decoded;
        }

        public string GetUri(string secret, string issuer, string account = null, Types type = Types.TOTP)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(secret));
            Contract.Requires(!string.IsNullOrWhiteSpace(issuer));
            Contract.Requires(type == Types.HOTP || type == Types.TOTP);
            Contract.Ensures(!string.IsNullOrWhiteSpace(Contract.Result<string>()));
            return string.Format("otpauth://{0}/{1}{2}?secret={3}&issuer={1}",
                type.ToString().ToLower(),
                issuer,
                !string.IsNullOrWhiteSpace(account) ? ":" + account : null,
                secret);
        }

        public enum Types
        {
            HOTP,
            TOTP,
        }
    }
}
