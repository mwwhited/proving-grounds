using System;
using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public class AmortizationEngine : IAmortizationEngine
    {
        public IBillingEngine BillingEngine { get; private set; }
        public ITaxEngine TaxEngine { get; private set; }

        public AmortizationEngine(IBillingEngine billingEngine, ITaxEngine taxEngine)
        {
            this.TaxEngine = taxEngine ?? new TaxEngine();
            this.BillingEngine = billingEngine ?? new BillingEngine(this.TaxEngine);
        }

        public IEnumerable<ISchedule> GetOriginalSchedule(IAccount account)
        {
            var lastPaymentDate = account.OriginationsDate;
            var paymentDate = account.FirstPaymentDate;
            var outstandingBalanace = account.Financed;

            do
            {
                var interest = this.BillingEngine.GetInterest(account.Apr, outstandingBalanace, lastPaymentDate, paymentDate);
                var tax = this.TaxEngine.GetTax(amount: interest, transactionType: TransactionType.Interest);
                var principal = Math.Min(account.BasePayment - interest, outstandingBalanace);

                yield return new Schedule(paymentDate, interest, principal, tax, outstandingBalanace);

                lastPaymentDate = paymentDate;
                paymentDate = paymentDate.AddMonths(1);
                outstandingBalanace -= principal;
            } while (outstandingBalanace > 0);
        }
    }
}