using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Xml.Linq;

namespace OobDev.Common.Accessors
{
    [ContractClass(typeof(ICredentialValueContract))]
    public interface ICredentialValue
    {
        string Resource { get; }
        string Username { get; }
        string Password { get; }

        IEnumerable<KeyValuePair<string, string>> Properties { get; }
    }

    [ContractClassFor(typeof(ICredentialValue))]
    internal abstract class ICredentialValueContract : ICredentialValue
    {
        public string Resource
        {
            get
            {
                Contract.Ensures(!string.IsNullOrEmpty(Contract.Result<string>()));
                throw new Exception();
            }
        }

        public string Username
        {
            get {  throw new Exception(); }
        }

        public string Password
        {
            get { throw new Exception(); }
        }

        public IEnumerable<KeyValuePair<string, string>> Properties
        {
            get
            {
                //Contract.Ensures(Contract.Result<IEnumerable<KeyValuePair<string, string>>>() != null);
                throw new Exception();
            }
        }
    }
}
