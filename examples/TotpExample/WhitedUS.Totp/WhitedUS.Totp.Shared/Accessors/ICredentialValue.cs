using System;
using System.Diagnostics.Contracts;
using System.Xml.Linq;

namespace WhitedUS.Totp.Shared.Accessors
{
    [ContractClass(typeof(ICredentialValueContract))]
    public interface ICredentialValue
    {
        string Resource { get; }
        string Username { get; }
        string Password { get; }
    }

    [ContractClassFor(typeof(ICredentialValue))]
    internal abstract class ICredentialValueContract : ICredentialValue
    {
        public string Resource
        {
            get
            {
                Contract.Ensures(!string.IsNullOrWhiteSpace(Contract.Result<string>()));
                throw new NotImplementedException();
            }
        }

        public string Username
        {
            get
            {
                Contract.Ensures(!string.IsNullOrWhiteSpace(Contract.Result<string>()));
                throw new NotImplementedException();
            }
        }

        public string Password
        {
            get
            {
                Contract.Ensures(!string.IsNullOrWhiteSpace(Contract.Result<string>()));
                throw new NotImplementedException();
            }
        }
    }
}
