using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Xml.Linq;

namespace WhitedUS.Common.Security
{
    public class DigitalSignatureTools
    {
        public XElement CreateRsaKey()
        {
            var rsaProvider = new RSACryptoServiceProvider();
            var xml = rsaProvider.ToXmlString(false);
            return XElement.Parse(xml);
        }
        public string SignData(Stream input, XElement key)
        {
            var rsaProvider = new RSACryptoServiceProvider();
            rsaProvider.FromXmlString(key.ToString());
            var signatureBuffer = rsaProvider.SignData(input, new SHA1CryptoServiceProvider());
            var signature = Convert.ToBase64String(signatureBuffer);
            return signature;
        }
        public bool VerifyData(Stream input, XElement key, string signature)
        {
            var rsaProvider = new RSACryptoServiceProvider();
            var signatureBuffer = Convert.FromBase64String(signature);
            rsaProvider.FromXmlString(key.ToString());
            using (var buffer = new MemoryStream())
            {
                input.CopyTo(buffer);
                var result = rsaProvider.VerifyData(buffer.ToArray(), new SHA1CryptoServiceProvider(), signatureBuffer);
                return result;
            }
        }
    }
}
