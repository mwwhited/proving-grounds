namespace AccountingEngine.Cli
{
    public interface ITaxEngine
    {
        decimal GetTax(decimal amount, TransactionType transactionType);
    }
}