using System;
using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public interface IDunningEngine
    {
        IEnumerable<ITransaction> GetDunningTransactions(IEnumerable<ITransaction> transactions, DateTime postedDate, DateTime dueDate);
        IEnumerable<ITransaction> GetDunningSummary(IEnumerable<ITransaction> transactions, DateTime postedDate, DateTime dueDate);
    }
}