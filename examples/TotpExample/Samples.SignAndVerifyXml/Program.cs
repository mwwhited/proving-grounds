using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace Samples.SignAndVerifyXml
{
    class Program
    {
        static void Main(string[] args)
        {
            var licenseFilePathUnsigned = @"test.xml";

            var ns = XNamespace.Get("whitedus://licenses");
            var xLicense = new XElement(ns + "license",
                new XElement(ns + "expires", DateTime.Today.AddMonths(2))
                );
            xLicense.Save(licenseFilePathUnsigned);

            var licenseFilePathSigned = @"test_signed.xml";
            var keyFilePath = @"Samples.snk";

            Console.WriteLine("Signing XML");
            EncryptionUtils.SignXmlFile(licenseFilePathUnsigned, licenseFilePathSigned, EncryptionUtils.GetRSAFromSnkFile(keyFilePath));

            Console.WriteLine("Verifying XML");
            var result = EncryptionUtils.VerifyXmlFile(licenseFilePathSigned, EncryptionUtils.GetPublicKeyFromAssembly(Assembly.GetExecutingAssembly()));
            if (result)
            {
                Console.WriteLine("Successfully verified signature");
            }
            else
            {
                Console.WriteLine("SIGNATURE INVALID");
            }
            Console.ReadKey();
        }
    }
}
