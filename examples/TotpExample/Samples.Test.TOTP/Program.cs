using Samples.Libs;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Samples.Test.TOTP
{
    class Program
    {
        static void Main(string[] args)
        {
            Program.TestCodes();
        }

        private static void TestCodes()
        {
            var otp = new OneTimeCode();
            var secret = Program.GetSecret(otp);
            Console.WriteLine("S: {0}", secret);
            Console.WriteLine(otp.GetUri(issuer: "Test", account: "User@Domain", secret: secret));

            //var password = otp.GetPassword(secret);
            //Console.WriteLine("P: {0}", password);

            Console.WriteLine("Code? ");
            var passcode = Console.ReadLine();
            var ret = otp.IsValid(secret, passcode, 4);
            Console.WriteLine(ret);
            Console.ReadLine();
        }

        private static string GetSecret(OneTimeCode otp)
        {
            var secretfile = "secret.txt";
            string secret;
            if (!File.Exists(secretfile))
            {
                secret = otp.GenerateSecret();
                File.WriteAllText(secretfile, secret);
            }
            else
            {
                secret = File.ReadAllText(secretfile);
            }
            return secret;
        }
    }
}
