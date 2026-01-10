namespace AccountingEngine.Cli
{
    public enum TransactionType
    {
        Principal,
        Interest,
        Tax,
        LateFee,

        //these are payments
        Payment,
        Credit,
        Refund,
        Funding,
        GoodWill,
    }
}