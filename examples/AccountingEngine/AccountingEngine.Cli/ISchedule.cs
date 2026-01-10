using System;

namespace AccountingEngine.Cli
{
    public interface ISchedule
    {
        DateTime Date { get; }
        decimal EndingBalanace { get; }
        decimal Interest { get; }
        decimal Principal { get; }
        decimal StartingBalance { get; }
        decimal Tax { get; }
        decimal Total { get; }
    }
}