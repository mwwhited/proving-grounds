using System;
using System.Collections.Generic;
using System.Linq;

namespace AccountingEngine.Cli
{
    public class TerminationEngine : ITerminationEngine
    {
        public IClearingEngine ClearingEngine { get; private set; }

        public TerminationEngine(IClearingEngine clearingEngine)
        {
            this.ClearingEngine = clearingEngine ?? new ClearingEngine();
        }

        public decimal Outstanding(IEnumerable<ITransaction> history)
        {
            var outstandingFees = history.Where(t => !t.IsClear && t.Type != TransactionType.Principal)
                                         .Sum(t => t.Amount);

            var unpaidPrincipal = history.Where(t => t.Type == TransactionType.Principal)
                                         .Sum(t=>t.Amount);

            var totalOutstanding = outstandingFees - unpaidPrincipal;
            return totalOutstanding;
        }

        public IEnumerable<ITransaction> TerminateContract(IEnumerable<ITransaction> history, DateTime date)
        {
            var outstanding = this.Outstanding(history);
            
            //if (outstanding < -100.00m)
            //    throw new NotSupportedException();

            if (outstanding > 0)
            {
                //Note: Refund
                yield return new Transaction
                {
                    EffectiveDate = date,
                    PostedDate = date,
                    Amount = -outstanding,
                    Type = TransactionType.Refund,
                    SubType = TransactionSubType.Termination,
                };
            }
            else if (outstanding < 0)
            {
                //Note: credit
                yield return new Transaction
                {
                    EffectiveDate = date,
                    PostedDate = date,
                    Amount = -outstanding,
                    Type = TransactionType.GoodWill,
                    SubType = TransactionSubType.Termination,
                };

            }

            yield break;
        }

    }
}