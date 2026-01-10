using System;
using System.Collections.Generic;
using System.Text;
using Windows.Security.Cryptography;
using Windows.Security.Cryptography.Core;

namespace WhitedUS.Totp.Shared.Security
{
    public static class EncryptionTools
    {
        public static byte[] HMACSHA1(byte[] secret, byte[] input)
        {
            var crypt = MacAlgorithmProvider.OpenAlgorithm(MacAlgorithmNames.HmacSha1);

            var keyBuffer = CryptographicBuffer.CreateFromByteArray(secret);
            var key = crypt.CreateKey(keyBuffer);

            var inputBuffer = CryptographicBuffer.CreateFromByteArray(input);

            var signatureBuffer = CryptographicEngine.Sign(key, inputBuffer);
            var signature = new byte[signatureBuffer.Length];
            CryptographicBuffer.CopyToByteArray(signatureBuffer, out signature);

            return signature;
        }

        public static byte[] GenerateSecret(uint length)
        {
            var secretBuffer = CryptographicBuffer.GenerateRandom(length);
            var secret = new byte[secretBuffer.Length];
            CryptographicBuffer.CopyToByteArray(secretBuffer, out secret);
            return secret;
        }
    }
}
