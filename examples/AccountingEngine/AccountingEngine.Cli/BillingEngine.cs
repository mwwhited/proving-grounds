using System;
using System.Collections.Generic;
using System.Linq;

namespace AccountingEngine.Cli
{
    public class BillingEngine : IBillingEngine
    {
        public ITaxEngine TaxEngine { get; private set; }

        public BillingEngine(ITaxEngine taxEngine)
        {
            this.TaxEngine = taxEngine ?? new TaxEngine();
        }

        public IEnumerable<ITransaction> GetAdjustments(IEnumerable<ITransaction> transactions, decimal apr, decimal outstandingBalanace, DateTime lastPaymentDate, DateTime paymentDate, decimal payment)
        {
            var previousTrans = transactions.Where(t => !t.IsClear && t.EffectiveDate <= paymentDate);

            var interest = this.GetInterest(apr, outstandingBalanace, lastPaymentDate, paymentDate)
                + previousTrans.Where(t => t.Type == TransactionType.Interest).Sum(t => t.Amount);
            var tax = this.TaxEngine.GetTax(interest, TransactionType.Interest);

            if (interest != 0m)
                yield return new Transaction
                {
                    EffectiveDate = paymentDate,
                    PostedDate = paymentDate,
                    Amount = -interest,
                    Type = TransactionType.Interest,
                    SubType = TransactionSubType.BillingAdjustment,
                };

            if (tax != 0m)
                yield return new Transaction
                {
                    EffectiveDate = paymentDate,
                    PostedDate = paymentDate,
                    Amount = -tax,
                    Type = TransactionType.Tax,
                    SubType = TransactionSubType.BillingAdjustment,
                };


            var X = previousTrans.Where(t => t.Type < TransactionType.Payment)
                                        .Sum(t => t.Amount);

            var princpal = previousTrans.Where(t => t.Type < TransactionType.Payment)
                                        .Sum(t => t.Amount)
                                + payment;

            //if (princpal > 0)
            //{
            //    //Principal Application
            //}

            if (princpal != 0m)
                yield return new Transaction
                {
                    EffectiveDate = paymentDate,
                    PostedDate = paymentDate,
                    Amount = -princpal,
                    Type = TransactionType.Principal,
                    SubType = TransactionSubType.BillingAdjustment,
                };

        }

        public decimal GetInterest(decimal apr, decimal outstandingBalanace, DateTime lastPaymentDate, DateTime paymentDate)
        {
            return Math.Round(
                (decimal)((paymentDate - lastPaymentDate).TotalDays)
                * (apr / 365)
                * outstandingBalanace
                , 2);
        }


        public IEnumerable<ITransaction> GetMonthlyBillings(IAccount account, decimal outstandingBalanace, DateTime lastPaymentDate, DateTime paymentDueDate)
        {
            var interest = this.GetInterest(account.Apr, outstandingBalanace, lastPaymentDate, paymentDueDate);
            var tax = this.TaxEngine.GetTax(amount: interest, transactionType: TransactionType.Interest);
            var principal = Math.Min(account.BasePayment - interest, outstandingBalanace);
            //var total = interest + tax + principal;

            if (principal != 0)
                yield return new Transaction
                             {
                                 PostedDate = paymentDueDate.AddDays(-5),
                                 EffectiveDate = paymentDueDate,
                                 Amount = -principal,
                                 Type = TransactionType.Principal,
                                 SubType = TransactionSubType.MonthlyBilling,
                             };
            if (interest != 0)
                yield return new Transaction
                             {
                                 PostedDate = paymentDueDate.AddDays(-5),
                                 EffectiveDate = paymentDueDate,
                                 Amount = -interest,
                                 Type = TransactionType.Interest,
                                 SubType = TransactionSubType.MonthlyBilling,
                             };
            if (tax != 0)
                yield return new Transaction
                             {
                                 PostedDate = paymentDueDate.AddDays(-5),
                                 EffectiveDate = paymentDueDate,
                                 Amount = -tax,
                                 Type = TransactionType.Tax,
                                 SubType = TransactionSubType.MonthlyBilling,
                             };
        }
    }
}