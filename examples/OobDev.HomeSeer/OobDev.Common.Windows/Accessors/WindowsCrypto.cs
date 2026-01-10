using System;
using OobDev.Common.Accessors;
using System.IO;
using System.Security.Cryptography;

namespace OobDev.Common.Accessors
{
    public class WindowsCrypto : ICrypto
    {
        public byte[] DecrpytAES(byte[] key, byte[] salt, byte[] data)
        {
            using (var rfc2898 = new Rfc2898DeriveBytes(key, salt, 1000))
            using (var encrypted = new MemoryStream())
            using (var aes = new AesManaged()
            {
                KeySize = 256,
                BlockSize = 128,
                Mode = CipherMode.CBC,
            })
            {
                aes.Key = rfc2898.GetBytes(aes.KeySize / 8);
                aes.IV = rfc2898.GetBytes(aes.BlockSize / 8);

                using (var cs = new CryptoStream(encrypted, aes.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(data, 0, data.Length);
                    cs.Close();
                }
                return encrypted.ToArray();
            }
        }

        public byte[] EncryptAES(byte[] key, byte[] salt, byte[] data)
        {
            using (var rfc2898 = new Rfc2898DeriveBytes(key, salt, 1000))
            using (var encrypted = new MemoryStream())
            using (var aes = new AesManaged()
            {
                KeySize = 256,
                BlockSize = 128,
                Mode = CipherMode.CBC,
            })
            {
                aes.Key = rfc2898.GetBytes(aes.KeySize / 8);
                aes.IV = rfc2898.GetBytes(aes.BlockSize / 8);

                using (var cs = new CryptoStream(encrypted, aes.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(data, 0, data.Length);
                    cs.Close();
                }
                return encrypted.ToArray();
            }
        }

        public byte[] GenerateKey(int keyLength = 128)
        {
            using (var rand = new RNGCryptoServiceProvider())
            {
                var key = new byte[keyLength];
                rand.GetBytes(key);
                return key;
            }
        }

        public byte[] HashSHA256(byte[] data)
        {
            using (var sha = new SHA256Managed())
            {
                return sha.ComputeHash(data);
            }
        }
    }
}