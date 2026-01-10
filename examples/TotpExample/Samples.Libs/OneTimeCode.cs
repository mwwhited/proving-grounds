using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Samples.Libs
{
    // http://stackoverflow.com/questions/51363/how-does-the-licenses-licx-based-net-component-licensing-model-work
    // http://www.developer.com/net/csharp/article.php/10918_3074001_2/Applications-Licensing-using-the-NET-Framework.htm
    // http://msdn.microsoft.com/en-us/library/system.componentmodel.licensemanager(v=vs.110).aspx 
    // http://msdn.microsoft.com/en-us/library/system.componentmodel.licfilelicenseprovider(v=vs.110).aspx
    // http://msdn.microsoft.com/en-us/library/ha0k3c9f(v=vs.110).aspx (License Compiler)
    // http://stackoverflow.com/questions/359342/an-effective-method-for-encrypting-a-license-file
    // http://stackoverflow.com/questions/1900462/licenseprovider-in-net-using-rsa-encryption-to-protect-product-license

    //[LicenseProvider(typeof(TestLicenseProvider))]
    public class OneTimeCode : IDisposable
    {
        private License license;
        public OneTimeCode()
        {
            //license = LicenseManager.Validate(typeof(OneTimeCode), this);
        }

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

            var hmac = new HMACSHA1(key, true);

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
                Console.Write("{0}", i);
                Console.WriteLine("{0}", token);
                if (token == this.GetToken(secret, this.GetCurrentCounter() + i))
                {
                    Console.WriteLine("+{0}", i);
                    return true;
                }
                if (token == this.GetToken(secret, this.GetCurrentCounter() - i))
                {
                    Console.WriteLine("-{0}", i);
                    return true;
                }
            }
            Console.WriteLine();
            return false;
        }

        public string GenerateSecret()
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


        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }
        ~OneTimeCode()
        {
            this.Dispose(false);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (license != null)
                {
                    license.Dispose();
                    license = null;
                }
            }
        }
    }
}
