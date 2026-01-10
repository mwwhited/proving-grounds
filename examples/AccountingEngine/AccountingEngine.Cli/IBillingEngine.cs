using System;
using System.Collections.Generic;

namespace AccountingEngine.Cli
{
    public interface IBillingEngine
    {
        decimal GetInterest(decimal apr, decimal outstandingBalanace, DateTime lastPaymentDate, DateTime paymentDate);
        IEnumerable<ITransaction> GetAdjustments(IEnumerable<ITransaction> transactions, decimal apr, decimal outstandingBalanace, DateTime lastPaymentDate, DateTime paymentDate, decimal payment);

        IEnumerable<ITransaction> GetMonthlyBillings(IAccount account, decimal outstandingBalanace, DateTime lastPaymentDate, DateTime paymentDueDate);
    }
}