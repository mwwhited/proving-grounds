using System;
using System.Collections.Generic;
using System.Linq;

namespace AccountingEngine.Cli
{
    public class BillingSimulator : IBillingSimulator
    {
        public bool AllowAdjustPayments { get; set; }
        public bool AllowAdjustOffset { get; set; }

        public IBillingEngine BillingEngine { get; private set; }
        public ITaxEngine TaxEngine { get; private set; }
        public IDunningEngine DunningEngine { get; private set; }
        public IClearingEngine ClearingEngine { get; private set; }
        public ITerminationEngine TerminationEngine { get; private set; }
        public IAccountEngine AccountEngine { get; private set; }

        public BillingSimulator(IBillingEngine billingEngine,
                                ITaxEngine taxEngine,
                                IDunningEngine dunningEngine,
                                IClearingEngine clearingEngine,
                                ITerminationEngine terminationEngine,
                                IAccountEngine accountEngine)
        {
            this.TaxEngine = taxEngine ?? new TaxEngine();
            this.BillingEngine = billingEngine ?? new BillingEngine(this.TaxEngine);
            this.DunningEngine = dunningEngine ?? new DunningEngine();
            this.ClearingEngine = clearingEngine ?? new ClearingEngine();
            this.TerminationEngine = terminationEngine ?? new TerminationEngine(this.ClearingEngine);
            this.AccountEngine = accountEngine; // ?? new AccountEngine();
        }

        public IEnumerable<ITransaction> CreateTransactions(IAccount account)
        {
            var rnd = new Random();

            var lastPaymentDate = account.OriginationsDate;
            var paymentDueDate = account.FirstPaymentDate;
            var outstandingBalanace = account.Financed;

            var history = new List<ITransaction>();
            var fundingTransactions = this.AccountEngine.FundAccount(account);
            foreach (var fundingTransaction in fundingTransactions)
            {
                yield return fundingTransaction;
                history.Add(fundingTransaction);
            }

            do
            {
                //Note: Do Billing

                //Note: moved this to the billing engine
                var monthlyBillings = this.BillingEngine.GetMonthlyBillings(account, outstandingBalanace, lastPaymentDate, paymentDueDate);
                foreach (var mb in monthlyBillings)
                {
                    yield return mb;
                    history.Add(mb);
                }

                var daysOffset = this.AllowAdjustOffset ? rnd.Next(0, 28) : 0;

                //Note: Do Dunning
                if (daysOffset > 1)
                {
                    var dunningDates = Enumerable.Range(0, daysOffset - 1)
                                                 .Select(d => paymentDueDate.AddDays(d));

                    foreach (var date in dunningDates)
                    {
                        var dunningTransactions = this.DunningEngine.GetDunningSummary(history, date, paymentDueDate.AddMonths(1));

                        foreach (var dt in dunningTransactions)
                        {
                            yield return dt;
                            history.Add(dt);
                        }
                    }
                }


                //Note: Do Payments
                var paymentDate = paymentDueDate.AddDays(daysOffset);
                // Uncleared outstanding
                var total = -history.Where(t => !t.IsClear && t.Type < TransactionType.Payment && t.EffectiveDate <= paymentDate)
                                   .Sum(t => t.Amount);

                if (this.AllowAdjustPayments)
                {
                    //NOTE: adjust payment amounts 
                    var paymentAdjOdds = rnd.NextDouble();
                    if (paymentAdjOdds < .05)
                    {
                        // under
                        total = Math.Round(total * .75m, 2);
                    }
                    else if (paymentAdjOdds > .95)
                    {
                        //over 
                        total = Math.Round(total * 1.25m, 2);
                    }
                }

                var paymentTransaction = new Transaction
                {
                    PostedDate = paymentDate,
                    EffectiveDate = paymentDate,
                    Amount = total,
                    SubType = TransactionSubType.PaymentReceived,
                    Type = TransactionType.Payment,
                };
                yield return paymentTransaction;
                history.Add(paymentTransaction);

                //Note: Adjust SIL
                var adjustments = this.BillingEngine.GetAdjustments(history, account.Apr, outstandingBalanace, lastPaymentDate, paymentDate, payment: total);
                foreach (var adj in adjustments)
                {
                    yield return adj;
                    history.Add(adj);
                }

                //note: Do Clearing
                var clearingAdjustments = this.ClearingEngine.RunClearing(history, TransactionSubType.BillingAdjustment);
                foreach (var clearingAdjustment in clearingAdjustments)
                {
                    yield return clearingAdjustment;
                    history.Add(clearingAdjustment);
                }

                outstandingBalanace = history.Where(t => t.IsClear && t.Type == TransactionType.Principal && t.EffectiveDate <= paymentDueDate)
                                             .Sum(t => t.Amount);
                lastPaymentDate = paymentDueDate;
                paymentDueDate = paymentDueDate.AddMonths(1);

                Console.WriteLine(outstandingBalanace);

                //Note: Allow accounts to close if outstanding is less than $100.00
                //var pendingOutstanding = -history.Where(t => !t.IsClear)
                //                                .Sum(t => t.Amount);
                //var totalOutstanding = outstandingBalanace + pendingOutstanding;
                //if (totalOutstanding < 50m)
                //    break;

                var totalOutstanding = this.TerminationEngine.Outstanding(history);
                if (totalOutstanding > -100m)
                    break;


            } while (outstandingBalanace > 0m);


            var termDate = history.SelectMany(h => new[] { h.PostedDate, h.EffectiveDate }).Max().AddDays(1);
            //Note: termination account
            var terminated = this.TerminationEngine.TerminateContract(history, termDate);
            foreach (var term in terminated)
            {
                yield return term;
                history.Add(term);
            }

            //Note: clearing for terminations
            {
                var clearingAdjustments = this.ClearingEngine.RunClearing(history, TransactionSubType.TerminationAdjustment);
                foreach (var clearingAdjustment in clearingAdjustments)
                {
                    yield return clearingAdjustment;
                    history.Add(clearingAdjustment);
                }
            }
        }
    }
}