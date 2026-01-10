using System;
using System.Collections.Generic;
using System.Linq;

namespace AccountingEngine.Cli
{
    public class ClearingEngine : IClearingEngine
    {
        public IEnumerable<ITransaction> RunClearing(IEnumerable<ITransaction> history, TransactionSubType sub)
        {
            var pendingTransactions = history.Where(t => !t.IsClear)
                                             .OrderBy(t => t.EffectiveDate)
                                             .ThenBy(t => t.Type);

            var payments = pendingTransactions.Where(t => t.Type >= TransactionType.Payment);

            int nextId = (history.Max(t => t.ClearingID) + 1) ?? 1;
            foreach (var payment in payments)
            {
                var effTran = pendingTransactions.TakeWhile(t => t != payment);
                var effSum = effTran.Sum(t => t.Amount);

                var difference = payment.Amount + effSum;

                if (difference > 0m)
                {
                    yield return new Transaction
                    {
                        EffectiveDate = payment.EffectiveDate,
                        PostedDate = payment.PostedDate,
                        Amount = -difference,
                        ClearingID = nextId,
                        Type = TransactionType.Principal,
                        SubType = sub,
                    };
                    difference = 0m;
                }
                else if (difference < 0m)
                {

                    //TODO: add splitting logic
                    yield return new Transaction
                    {
                        EffectiveDate = payment.EffectiveDate,
                        PostedDate = payment.PostedDate,
                        Amount = -difference,
                        ClearingID = nextId,
                        Type = TransactionType.Credit,
                        SubType = sub,
                    };
                    difference = 0m;
                }

                if (difference == 0m)
                {
                    foreach (var t in effTran)
                        t.ClearingID = nextId;
                    payment.ClearingID = nextId;
                }
                nextId++;
            }
        }
    }
}