using Microsoft.VisualBasic;
using System;
using System.Diagnostics.Contracts;

namespace AccountingEngine.Cli
{
    public class Account : IAccount
    {
        public decimal Apr { get; private set; }
        public decimal Financed { get; private set; }
        public int Terms { get; private set; }
        public DateTime OriginationsDate { get; private set; }
        public int DayDue { get; private set; }

        public decimal BasePayment
        {
            get { return (decimal)Math.Round(this.Apr == 0m ? (double)this.Financed / this.Terms : Financial.Pmt((double)this.Apr / 12d, this.Terms, -(double)this.Financed), 2); }
        }
        public DateTime FirstPaymentDate
        {
            get
            {
                var dt = this.OriginationsDate.AddMonths(1).AddDays(-this.OriginationsDate.Day + this.DayDue);
                return (dt - this.OriginationsDate).TotalDays < 30 ? dt.AddMonths(1) : dt;
            }
        }

        [ContractInvariantMethod]
        private void ObjectInvariant()
        {
            Contract.Assume(this.Financed >= 0m);
            Contract.Assume(this.Apr >= 0m && this.Apr < 0.25m);
            Contract.Assume(this.Terms > 6 && this.Terms <= 96);

            Contract.Invariant(this.Financed >= 0m);
            Contract.Invariant(this.Apr >= 0m && this.Apr < 0.25m);
            Contract.Invariant(this.Terms > 6 && this.Terms <= 96);
        }

        public Account(decimal financed, int terms, decimal apr, DateTime? originationDate = null, int? dayDue = null)
        {
            Contract.Requires(financed >= 0m);
            Contract.Requires(apr >= 0m && apr < 0.25m);
            Contract.Requires(terms >= 6 && terms <= 96);
            Contract.Requires(!dayDue.HasValue || (dayDue > 0 && dayDue < 28));

            this.Financed = financed;
            this.Terms = terms;
            this.Apr = apr;
            this.OriginationsDate = originationDate ?? DateTime.Today;
            this.DayDue = Math.Min(dayDue ?? this.OriginationsDate.Day, 28);
        }
    }
}