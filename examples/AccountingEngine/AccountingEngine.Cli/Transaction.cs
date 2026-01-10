using System;

namespace AccountingEngine.Cli
{
    public class Transaction : ITransaction
    {
        public decimal Amount { get; internal set; }
        public int? ClearingID { get; set; }
        public DateTime EffectiveDate { get; internal set; }
        public DateTime PostedDate { get; internal set; }
        public TransactionSubType SubType { get; internal set; }
        public TransactionType Type { get; internal set; }

        public bool IsClear
        {
            get { return this.ClearingID.HasValue; }
        }
        public override string ToString()
        {
            return string.Format("{0:yyyy-MM-dd}: ${1:0.00} ({2}/{3}) [{4}]", 
                this.EffectiveDate,
                this.Amount,
                this.Type,
                this.SubType,
                this.ClearingID
                );
        }
    }
}