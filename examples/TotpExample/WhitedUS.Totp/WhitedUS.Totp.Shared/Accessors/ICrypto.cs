using System.Diagnostics.Contracts;
namespace WhitedUS.Totp.Shared.Accessors
{
    [ContractClass(typeof(ICryptoContract))]
    public interface ICrypto
    {
        byte[] Encrypt(byte[] data);
        byte[] Decrpyt(byte[] data);
    }

    [ContractClassFor(typeof(ICrypto))]
    internal abstract class ICryptoContract : ICrypto
    {
        public byte[] Encrypt(byte[] data)
        {
            Contract.Requires(data != null);
            Contract.Ensures(Contract.Result<byte[]>() != null);
            throw new System.NotImplementedException();
        }

        public byte[] Decrpyt(byte[] data)
        {
            Contract.Requires(data != null);
            Contract.Ensures(Contract.Result<byte[]>() != null);
            throw new System.NotImplementedException();
        }
    }
}
