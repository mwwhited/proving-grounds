using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public interface IAmortizationEngine
    {
        IEnumerable<ISchedule> GetOriginalSchedule(IAccount account);
    }
}