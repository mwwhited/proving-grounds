using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccountingEngine.Cli
{
    public enum TransactionSubType
    {
        MonthlyBilling,
        PaymentReceived,
        BillingAdjustment,
        PaymentAdjustment,
        Dunning,
        Originations,
        Termination,
        TerminationAdjustment,
    }
}
