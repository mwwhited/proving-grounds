using System;
using System.Linq;

namespace AccountingEngine.Cli
{
    class Program
    {
        static void Main(string[] args)
        {
            var accountEngine = new AccountEngine_Fixed();
            
            var taxEngine = new TaxEngine();
            var billingEngine = new BillingEngine(taxEngine);
            var dunningEngine = new DunningEngine();
            var clearingEngine = new ClearingEngine();
            var terminationEngine = new TerminationEngine(clearingEngine);
            var amortizationEngine = new AmortizationEngine(billingEngine, taxEngine);
            var billingSimulator = new BillingSimulator(billingEngine, taxEngine, dunningEngine, clearingEngine, terminationEngine, accountEngine);
            var exporter = new SerializeEngine();

            var rand = new Random();
            var ts = DateTime.Now;
            for (var x = 0; x < 1; x++)
            {
                var account = accountEngine.GetSampleAccount();

                var fileName = string.Format("ae-{0:yyyyMMddHHmmss}.xml", ts = ts.AddSeconds(1));
                Console.WriteLine(fileName);

                var schedule = amortizationEngine.GetOriginalSchedule(account).ToList();
                var transactions = billingSimulator.CreateTransactions(account).ToList();

                var xml = exporter.GetXml(account, schedule, transactions);
                xml.Save(fileName);
            }
        }
    }
}
