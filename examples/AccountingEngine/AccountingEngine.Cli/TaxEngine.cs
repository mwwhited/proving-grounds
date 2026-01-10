using System;

namespace AccountingEngine.Cli
{
    public class TaxEngine : ITaxEngine
    {
        public decimal GetTax(decimal amount, TransactionType transactionType)
        {
            switch (transactionType)
            {
                case TransactionType.Payment:
                case TransactionType.Credit:
                case TransactionType.Principal:
                case TransactionType.Tax:
                default:
                    return 0m;
                case TransactionType.Interest:
                    return Math.Round(amount * .16m, 2);
            }
        }
    }
}