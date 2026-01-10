using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AccountingEngine.Cli
{
    public abstract class AccountEngineBase : IAccountEngine
    {
        public abstract IAccount GetSampleAccount();

        public IEnumerable<ITransaction> FundAccount(IAccount account)
        {
            var lastPaymentDate = account.OriginationsDate;
            var paymentDueDate = account.FirstPaymentDate;
            var outstandingBalanace = account.Financed;

            yield return new Transaction
            {
                Amount = outstandingBalanace,
                EffectiveDate = lastPaymentDate,
                PostedDate = lastPaymentDate,
                ClearingID = 1,
                Type = TransactionType.Principal,
                SubType = TransactionSubType.Originations,
            };
            yield return new Transaction
            {
                Amount = -outstandingBalanace,
                EffectiveDate = lastPaymentDate,
                PostedDate = lastPaymentDate,
                ClearingID = 1,
                Type = TransactionType.Funding,
                SubType = TransactionSubType.Originations,
            };
        }
    }

    public class AccountEngine_Fixed : AccountEngineBase
    {
        public override  IAccount GetSampleAccount()
        {
            return new Account(
                    financed: 50000.00m,
                    terms: 36,
                    apr: .05m,
                    dayDue: 1
                    );
        }
    }
    public class AccountEngine_Random : AccountEngineBase
    {
        private Random Rand = new Random();

        private int GetDay()
        {
            return new[] { 1, 15 }[this.Rand.Next(0, 2)];
        }

        private decimal GetApr()
        {
            return Math.Round((decimal)this.Rand.NextDouble() / 10, 4);
        }

        private decimal GetAmountFinanced()
        {
            return Math.Round((decimal)(this.Rand.NextDouble() * 50000.00), 2);
        }

        private int GetTerms()
        {
            return this.PossibleTerms[this.Rand.Next(this.PossibleTerms.Length)];
        }

        private int[] PossibleTerms
        {
            get { return new[] { 18, 24, 36, 39, 48, 60, 72, }; }
        }

        public override  IAccount GetSampleAccount()
        {
            return new Account(
                    financed: this.GetAmountFinanced(),
                    terms: this.GetTerms(),
                    apr: this.GetApr(),
                    dayDue: this.GetDay()
                    );
        }
    }
}
