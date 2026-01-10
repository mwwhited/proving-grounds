using System;
using System.Collections.Generic;
using System.Linq;

namespace AccountingEngine.Cli
{
    public class DunningEngine : IDunningEngine
    {
        public IEnumerable<ITransaction> GetDunningSummary(IEnumerable<ITransaction> transactions, DateTime postedDate, DateTime dueDate)
        {
            return from dt in this.GetDunningTransactions(transactions, postedDate, dueDate)
                   group dt by new { dt.Type, dt.SubType } into dts
                   select new Transaction
                   {
                       PostedDate = postedDate,
                       EffectiveDate = dueDate,
                       Amount = dts.Sum(d => d.Amount),

                       Type = dts.Key.Type,
                       SubType = dts.Key.SubType,
                   };
        }

        public IEnumerable<ITransaction> GetDunningTransactions(IEnumerable<ITransaction> transactions, DateTime postedDate, DateTime dueDate)
        {
            foreach (var tran in transactions.Where(t => !t.IsClear && t.EffectiveDate <= postedDate))
            {
                var days = (decimal)((postedDate - tran.EffectiveDate).TotalDays);
                if (days < 11)
                    continue;
                else if (days > 11)
                    days = 1;
                switch (tran.Type)
                {
                    case TransactionType.Principal:
                    case TransactionType.Interest:
                        yield return new Transaction
                        {
                            EffectiveDate = dueDate,
                            PostedDate = postedDate,
                            Type = TransactionType.LateFee,
                            SubType = TransactionSubType.Dunning,
                            Amount = Math.Round(tran.Amount * days * (.16m / 30m), 2),
                        };
                        break;
                    case TransactionType.Payment:
                    case TransactionType.Credit:
                    case TransactionType.Tax:
                    default:
                        break;
                }
            }
        }
    }
}