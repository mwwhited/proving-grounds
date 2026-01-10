using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common.Security.Cryptography
{
    public class OneTimeCode
    {
        public static readonly DateTime UNIX_EPOCH = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
        public static long GetCurrentCounter()
        {
            var counter = (long)(DateTime.UtcNow - OneTimeCode.UNIX_EPOCH).TotalSeconds / 30;
            return counter;
        }

        public static string GenerateToken(string secret, long iterationNumber, int digits = 6)
        {
            var counter = BitConverter.GetBytes(iterationNumber);

            if (BitConverter.IsLittleEndian)
                Array.Reverse(counter);

            var key = OneTimeCode.GetKey(secret);

            using (var hmac = new HMACSHA1(key, true))
            {
                var hash = hmac.ComputeHash(counter);

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
        }

        public static string GetToken(string secret, long? counter = null)
        {
            return OneTimeCode.GenerateToken(secret, counter ?? OneTimeCode.GetCurrentCounter());
        }

        public static bool IsValid(string secret, string token, int checkAdjacentIntervals = 1)
        {
            if (token == OneTimeCode.GetToken(secret))
                return true;

            if (checkAdjacentIntervals < 1)
                checkAdjacentIntervals = 1;

            for (int i = 1; i <= checkAdjacentIntervals; i++)
            {
                string check;
                if (token == (check = OneTimeCode.GetToken(secret, OneTimeCode.GetCurrentCounter() + i)))
                {
                    return true;
                }
                if (token == (check = OneTimeCode.GetToken(secret, OneTimeCode.GetCurrentCounter() - i)))
                {
                    return true;
                }
            }
            return false;
        }

        public static string GenerateSecret()
        {
            var buffer = new byte[9];

            using (var rng = RNGCryptoServiceProvider.Create())
            {
                rng.GetBytes(buffer);
            }

            var secret = Convert.ToBase64String(buffer).Substring(0, 10).Replace('/', '0').Replace('+', '1');
            var encoded = Base32Encoding.ToString(Encoding.ASCII.GetBytes(secret));
            return encoded;
        }

        public static byte[] GetKey(string secret)
        {
            var decoded = Base32Encoding.ToBytes(secret);
            return decoded;
        }

        public static string GetUri(string secret, string issuer, string account = null, Types type = Types.TOTP)
        {
            Contract.Requires(!string.IsNullOrEmpty(secret));
            Contract.Requires(!string.IsNullOrEmpty(issuer));
            Contract.Ensures(!string.IsNullOrEmpty(Contract.Result<string>()));
            return $"otpauth://{type.ToString().ToLower()}/{issuer}{(!string.IsNullOrWhiteSpace(account) ? ":" + account : null)}?secret={secret}&issuer={issuer}";
        }

        public enum Types
        {
            HOTP,
            TOTP,
        }
    }
}
