using System;

namespace AccountingEngine.Cli
{
    public interface ITransaction
    {
        decimal Amount { get; }
        DateTime EffectiveDate { get; }
        bool IsClear { get; }
        DateTime PostedDate { get; }
        TransactionSubType SubType { get; }
        TransactionType Type { get; }
        int? ClearingID { get; set; }
    }
}