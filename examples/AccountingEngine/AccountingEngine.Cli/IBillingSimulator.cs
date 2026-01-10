using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public interface IBillingSimulator
    {
        IEnumerable<ITransaction> CreateTransactions(IAccount account);
    }
}