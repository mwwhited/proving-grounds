using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public interface IClearingEngine
    {
        IEnumerable<ITransaction> RunClearing(IEnumerable<ITransaction> history, TransactionSubType sub);
    }
}