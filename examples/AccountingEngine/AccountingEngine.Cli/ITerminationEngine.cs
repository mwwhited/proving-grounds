using System;
using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public interface ITerminationEngine
    {
        decimal Outstanding(IEnumerable<ITransaction> history);
        IEnumerable<ITransaction> TerminateContract(IEnumerable<ITransaction> history, DateTime date);
    }
}