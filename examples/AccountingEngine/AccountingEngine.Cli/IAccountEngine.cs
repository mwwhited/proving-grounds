using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AccountingEngine.Cli
{
    public interface IAccountEngine
    {
        IAccount GetSampleAccount();

        IEnumerable<ITransaction> FundAccount(IAccount account);
    }
}
