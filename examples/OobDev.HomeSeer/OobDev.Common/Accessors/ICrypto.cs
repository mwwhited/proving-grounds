using System.Diagnostics.Contracts;

namespace OobDev.Common.Accessors
{
    [ContractClass(typeof(ICryptoContract))]
    public interface ICrypto
    {
        byte[] GenerateKey(int keyLength = 128);
        byte[] EncryptAES(byte[] key, byte[] salt, byte[] data);
        byte[] DecrpytAES(byte[] key, byte[] salt, byte[] data);

        byte[] HashSHA256(byte[] data);
    }

    [ContractClassFor(typeof(ICrypto))]
    internal abstract class ICryptoContract : ICrypto
    {
        public byte[] GenerateKey(int keyLength = 128)
        {
            Contract.Requires(keyLength > 8);
            Contract.Requires(keyLength < ushort.MaxValue);
            Contract.Ensures(Contract.Result<byte[]>() != null);
            throw new System.Exception();
        }
        public byte[] EncryptAES(byte[] key, byte[] salt, byte[] data)
        {
            Contract.Requires(key != null);
            Contract.Requires(salt != null);
            Contract.Requires(data != null);
            Contract.Ensures(Contract.Result<byte[]>() != null);
            throw new System.Exception();
        }

        public byte[] DecrpytAES(byte[] key, byte[] salt, byte[] data)
        {
            Contract.Requires(key != null);
            Contract.Requires(salt != null);
            Contract.Requires(data != null);
            Contract.Ensures(Contract.Result<byte[]>() != null);
            throw new System.Exception();
        }

        public byte[] HashSHA256(byte[] data)
        {
            Contract.Requires(data != null);
            Contract.Ensures(Contract.Result<byte[]>() != null);
            throw new System.Exception();
        }
    }
}
