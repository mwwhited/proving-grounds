using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.Security.Cryptography;
using Windows.Security.Cryptography.Core;

namespace OobDev.Common.Accessors
{
    public class UniversalCrypto : ICrypto
    {
        public byte[] DecrpytAES(byte[] key, byte[] salt, byte[] data)
        {
            // https://social.msdn.microsoft.com/Forums/windowsapps/en-US/7cfcc576-1c2c-4a50-a546-09a45d3ff41f/aesmanaged-in-metro-winrt-application?forum=winappswithcsharp
            // http://stackoverflow.com/questions/17981408/how-to-encrypt-decrypt-using-aes-in-winrt
            //var provider = SymmetricKeyAlgorithmProvider.OpenAlgorithm(SymmetricAlgorithmNames.AesCbc);
            //provider.
            throw new Exception();
        }

        public byte[] EncryptAES(byte[] key, byte[] salt, byte[] data)
        {
            throw new Exception();
        }

        public byte[] GenerateKey(int keyLength = 128)
        {
            throw new Exception();
        }

        public byte[] HashSHA256(byte[] data)
        {
            var provider = HashAlgorithmProvider.OpenAlgorithm(HashAlgorithmNames.Sha256);
            var clear = CryptographicBuffer.CreateFromByteArray(data);
            var buffer = provider.HashData(clear);
            byte[] hash;
            CryptographicBuffer.CopyToByteArray(buffer, out hash);
            return hash;
        }
    }
}
