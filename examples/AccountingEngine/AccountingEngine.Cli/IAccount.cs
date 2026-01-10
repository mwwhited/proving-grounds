using System;

namespace AccountingEngine.Cli
{
    public interface IAccount
    {
        decimal Apr { get; }
        decimal BasePayment { get; }
        int DayDue { get; }
        decimal Financed { get; }
        DateTime FirstPaymentDate { get; }
        DateTime OriginationsDate { get; }
        int Terms { get; }
    }
}