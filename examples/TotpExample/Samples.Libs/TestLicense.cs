using Samples.SignAndVerifyXml;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Xml;
using System.Xml.Linq;

namespace Samples.Libs
{
    public sealed class TestLicense : License
    {
        private TestLicense(string key)
        {
            this._key = key;
        }

        internal static TestLicense Create(LicenseContext context, Type type, object instance, bool allowExceptions)
        {
            var asm = Assembly.GetEntryAssembly();
            var res = asm.GetManifestResourceNames().First(r => r.EndsWith(".test_signed.xml"));

            using (var resStream = asm.GetManifestResourceStream(res))
            {
                var sigValid = EncryptionUtils.VerifyXmlFile(resStream, EncryptionUtils.GetPublicKeyFromAssembly(asm));
                if (!sigValid)
                {
                    throw new LicenseException(type, instance, "license signature invalid");
                }


                resStream.Position = 0;
                var ns = XNamespace.Get("whitedus://licenses");
                var xLic = XElement.Load(resStream);
                if (xLic.Name.NamespaceName == ns.NamespaceName)
                {
                    var exp = xLic.Element(ns + "expires");
                    var date = (DateTime)exp;

                    if (ApplicationInformation.CompileDate <= date)
                    {
                        //Note: Is Valid
                        var lic =  new TestLicense(string.Format("License for \"{0}\" is good until {1:yyyy-MM-dd}", type, ApplicationInformation.CompileDate));
                        return lic;
                    }
                }

            }

            throw new LicenseException(type, instance, "license invalid");
        }
        private static bool VerifyXmlFile(string signedXmlPath, AsymmetricAlgorithm key)
        {
            var signedXml = new XmlDocument();
            signedXml.PreserveWhitespace = false;
            signedXml.Load(signedXmlPath);

            var nsm = new XmlNamespaceManager(new NameTable());
            nsm.AddNamespace("dsig", SignedXml.XmlDsigNamespaceUrl);

            var signatureGenerator = new SignedXml(signedXml);
            var signatureNode = signedXml.SelectSingleNode("//dsig:Signature", nsm);
            signatureGenerator.LoadXml((XmlElement)signatureNode);

            return signatureGenerator.CheckSignature(key);
        }

        public override void Dispose()
        {
        }

        private string _key;
        public override string LicenseKey
        {
            get { return this._key; }
        }
    }
}
