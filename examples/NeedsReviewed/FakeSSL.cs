using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.IO.Compression;
using System.Security.Cryptography;

namespace ConsoleApplication3
{
    public class Crypto
    {
        static void Main(string[] args)
        {
            //RSA rsa = RSA.Create();
            //byte[] buffer = rsa.EncryptValue(Encoding.ASCII.GetBytes("HelloWorld!!!"));
            //string outVal = Encoding.ASCII.GetString(rsa.DecryptValue(buffer));

            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            string rsaXml = rsa.ToXmlString(true);

            bool fOAEP = true;
            byte[] encrypted = rsa.Encrypt(Encoding.ASCII.GetBytes("HelloWorld!!!"), fOAEP);
            string outVal = Encoding.ASCII.GetString(rsa.Decrypt(encrypted, fOAEP));

            Client clnt = new Client();
            Server serv = new Server();

            byte[] clientPublicKey = clnt.GetPublicKey();                   //Clear Client Public Key
            byte[] serverPublicKey = serv.GetPublicKey(clientPublicKey);    //Encrypted Server Public Key
            byte[] sessionKey = clnt.GetSessionKey(serverPublicKey);        //Encrypted Session Key/IV
            serv.SetSessionKey(sessionKey);                                 //Encrypted Session Key/IV

            byte[] message1 = clnt.SendMessage("Hello");
            byte[] message2 = serv.SendMessage("World");
            serv.ReceiveMessage(message1);
            clnt.ReceiveMessage(message2);


            Client clnt2 = new Client();
            Server serv2 = new Server();
            byte[] clientPublicKey2 = clnt2.GetPublicKey();                 //Clear Client Public Key
            byte[] serverPublicKey2 = serv2.GetPublicKey(clientPublicKey2); //Encrypted Server Public Key
            byte[] sessionKey2 = clnt2.GetSessionKey(serverPublicKey2);     //Encrypted Session Key/IV
            serv2.SetSessionKey(sessionKey2);                               //Encrypted Session Key/IV

            serv2.ReceiveMessage(message1);
            clnt2.ReceiveMessage(message2);

        }

        public abstract class CryptoBase
        {
            protected SHA1CryptoServiceProvider hashProvider = new SHA1CryptoServiceProvider();
            protected RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            protected RSACryptoServiceProvider neighbour = null;
            protected bool _fOAEP = false;
            protected SymmetricAlgorithm sym = null;

            public byte[] SendMessage(string message)
            {
                return Encrypt(Encoding.UTF8.GetBytes(message));
            }

            public void ReceiveMessage(byte[] message)
            {
                Console.WriteLine(
                    string.Format(
                        "{0}: {1}",
                        this.GetType().Name,
                        Encoding.UTF8.GetString(Decrypt(message))
                        )
                    );
            }

            internal byte[] Encrypt(byte[] input)
            {
                if (input == null || input.Length < 1)
                    return null;

                using (MemoryStream encryptedStreamOut = new MemoryStream())
                {
                    using (MemoryStream rawStream = new MemoryStream(input))
                    using (CryptoStream cryptoStream = new CryptoStream(encryptedStreamOut, sym.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        byte[] buffer = new byte[1024];
                        int bufferLen;
                        do
                        {
                            bufferLen = rawStream.Read(buffer, 0, buffer.Length);
                            if (bufferLen > 0)
                                cryptoStream.Write(buffer, 0, bufferLen);
                        } while (bufferLen > 0);
                    }

                    byte[] encryptedData = encryptedStreamOut.ToArray();
                    byte[] signature = rsa.SignData(encryptedData, hashProvider);
                    byte[] messageOut = new byte[4 + 4 + encryptedData.Length + signature.Length];

                    Array.Copy(BitConverter.GetBytes(encryptedData.Length), 0, messageOut, 0, 4);
                    Array.Copy(BitConverter.GetBytes(signature.Length), 0, messageOut, 4, 4);
                    Array.Copy(encryptedData, 0, messageOut, 4 + 4, encryptedData.Length);
                    Array.Copy(signature, 0, messageOut, 4 + 4 + encryptedData.Length, signature.Length);

                    return messageOut;
                }
            }

            internal byte[] Decrypt(byte[] input)
            {
                if (input == null || input.Length < 1)
                    return null;

                int encryptedDataLength = BitConverter.ToInt32(input, 0);
                int signatureLength = BitConverter.ToInt32(input, 4);
                byte[] encryptedData = new byte[encryptedDataLength];
                Array.Copy(input, 4 + 4, encryptedData, 0, encryptedDataLength);
                byte[] signature = new byte[signatureLength];
                Array.Copy(input, 4 + 4 + encryptedDataLength, signature, 0, signatureLength);

                if (!neighbour.VerifyData(encryptedData, hashProvider, signature))
                    throw new InvalidOperationException("Signature does not match Neighbour");

                using (MemoryStream decryptedStream = new MemoryStream())
                {
                    using (MemoryStream encryptedStreamIn = new MemoryStream(encryptedData))
                    using (CryptoStream cryptoStream = new CryptoStream(encryptedStreamIn, sym.CreateDecryptor(), CryptoStreamMode.Read))
                    {
                        byte[] buffer = new byte[1024];
                        int bufferLen;
                        do
                        {
                            bufferLen = cryptoStream.Read(buffer, 0, buffer.Length);
                            if (bufferLen > 0)
                                decryptedStream.Write(buffer, 0, bufferLen);
                        } while (bufferLen > 0);
                    }

                    return decryptedStream.ToArray();
                }
            }
        }

        public sealed class Client : CryptoBase
        {
            public byte[] GetPublicKey()
            {
                return rsa.ExportCspBlob(false);
            }

            public byte[] GetSessionKey(byte[] serverKey)
            {
                byte[] part1 = new byte[serverKey.Length / 2];
                Array.Copy(serverKey, 0, part1, 0, part1.Length);
                byte[] part2 = new byte[serverKey.Length / 2];
                Array.Copy(serverKey, part1.Length, part2, 0, part2.Length);
                byte[] keyPart1 = rsa.Decrypt(part1, _fOAEP);
                byte[] keyPart2 = rsa.Decrypt(part2, _fOAEP);
                byte[] realServerKey = new byte[keyPart1.Length + keyPart2.Length];
                Array.Copy(keyPart1, 0, realServerKey, 0, keyPart1.Length);
                Array.Copy(keyPart2, 0, realServerKey, keyPart1.Length, keyPart2.Length);
                serverKey = keyPart1 = keyPart2 = part1 = part2 = null;
                GC.Collect(0, GCCollectionMode.Forced);

                if (neighbour != null)
                    neighbour.Clear();

                neighbour = new RSACryptoServiceProvider();
                neighbour.ImportCspBlob(realServerKey);

                if (sym != null)
                    sym.Clear();
                sym = SymmetricAlgorithm.Create();

                byte[] keyIv = new byte[4 + 4 + sym.IV.Length + sym.Key.Length];
                Array.Copy(BitConverter.GetBytes(sym.IV.Length), 0, keyIv, 0, 4);
                Array.Copy(BitConverter.GetBytes(sym.Key.Length), 0, keyIv, 4, 4);
                Array.Copy(sym.IV, 0, keyIv, 4 + 4, sym.IV.Length);
                Array.Copy(sym.Key, 0, keyIv, 4 + 4 + sym.IV.Length, sym.Key.Length);
                return neighbour.Encrypt(keyIv, _fOAEP);
            }
        }

        public sealed class Server : CryptoBase
        {
            public byte[] GetPublicKey(byte[] clientKey)
            {
                if (neighbour != null)
                    neighbour.Clear();

                neighbour = new RSACryptoServiceProvider();
                neighbour.ImportCspBlob(clientKey);

                byte[] serverKey = rsa.ExportCspBlob(false);
                byte[] buffer = new byte[serverKey.Length / 2];
                Array.Copy(serverKey, 0, buffer, 0, serverKey.Length / 2);
                byte[] part1 = neighbour.Encrypt(buffer, _fOAEP);
                Array.Copy(serverKey, serverKey.Length / 2, buffer, 0, serverKey.Length / 2);
                byte[] part2 = neighbour.Encrypt(buffer, _fOAEP);
                byte[] returnKey = new byte[part1.Length + part2.Length];
                Array.Copy(part1, 0, returnKey, 0, part1.Length);
                Array.Copy(part2, 0, returnKey, part1.Length, part2.Length);
                serverKey = buffer = part1 = part2 = null;
                GC.Collect(0, GCCollectionMode.Forced);
                return returnKey;
            }

            public void SetSessionKey(byte[] sessionKey)
            {
                byte[] clearSessionKey = rsa.Decrypt(sessionKey, _fOAEP);
                int ivLength = BitConverter.ToInt32(clearSessionKey, 0);
                int keyLength = BitConverter.ToInt32(clearSessionKey, 4);
                byte[] iv = new byte[ivLength];
                byte[] key = new byte[keyLength];

                Array.Copy(clearSessionKey, 4 + 4, iv, 0, ivLength);
                Array.Copy(clearSessionKey, 4 + 4 + ivLength, key, 0, keyLength);

                if (sym != null)
                    sym.Clear();
                sym = SymmetricAlgorithm.Create();

                sym.IV = iv;
                sym.Key = key;
            }
        }
    }
}
