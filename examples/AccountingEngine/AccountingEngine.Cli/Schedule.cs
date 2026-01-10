using System;

namespace AccountingEngine.Cli
{
    public class Schedule : ISchedule
    {
        public DateTime Date { get; private set; }
        public decimal Principal { get; private set; }
        public decimal Interest { get; private set; }
        public decimal Tax { get; private set; }
        public decimal StartingBalance { get; private set; }

        public decimal Total { get { return this.Principal + this.Interest + this.Tax; } }
        public decimal EndingBalanace { get { return this.StartingBalance - this.Principal; } }

        public Schedule(DateTime paymentDate, decimal interest, decimal principal, decimal tax, decimal startingBalanace)
        {
            this.Date = paymentDate;
            this.Interest = interest;
            this.Principal = principal;
            this.Tax = tax;
            this.StartingBalance = startingBalanace;
        }

        public override string ToString()
        {
            return string.Format("{0:yyyy-MM-dd}: P${1:0.00} I${2:0.00} T${3:0.00} - ${4:0.00}=>${5:0.00}",
                this.Date,
                this.Principal,
                this.Interest,
                this.Tax,
                this.StartingBalance,
                this.EndingBalanace
                );
        }
    }
}