using System;
using System.Collections.Generic;
using System.Xml.Linq;
using System.Linq;

namespace AccountingEngine.Cli
{
    public class SerializeEngine : ISerializeEngine
    {
        private XNamespace ns = "oobdev://AccountingEngine/2017/02";

        public IEnumerable<XElement> GetXml(IEnumerable<ITransaction> transactions)
        {
            return from t in transactions ?? Enumerable.Empty<ITransaction>()
                   orderby t.PostedDate, t.Type, t.SubType
                   select this.GetXml(t);
        }
        public XElement GetXml(ITransaction transaction)
        {
            return new XElement(ns + "transaction",
                    new XAttribute("dt.posted", transaction.PostedDate.ToShortDateString()),
                    new XAttribute("dt.effective", transaction.EffectiveDate.ToShortDateString()),
                    new XAttribute("amt", transaction.Amount),
                    new XAttribute("type", transaction.Type),
                    new XAttribute("sub", transaction.SubType),
                    new XAttribute("cid", transaction.ClearingID ?? -1)
                );
        }

        public IEnumerable<XElement> GetXml(IEnumerable<ISchedule> schedules)
        {
            return from t in schedules ?? Enumerable.Empty<ISchedule>()
                   orderby t.Date
                   select this.GetXml(t);
        }
        public XElement GetXml(ISchedule schedule)
        {
            return new XElement(ns + "schedule",
                new XAttribute("dt", schedule.Date.ToShortDateString()),
                new XAttribute("bal.st", schedule.StartingBalance),
                new XAttribute("principal", schedule.Principal),
                new XAttribute("interest", schedule.Interest),
                new XAttribute("tax", schedule.Tax),
                new XAttribute("total", schedule.Total),
                new XAttribute("bal.end", schedule.EndingBalanace)
                );
        }

        public XElement GetXml(IAccount account)
        {
            return new XElement(ns + "account",
                     new XAttribute("apr", account.Apr),
                     new XAttribute("base.pmt", account.BasePayment),
                     new XAttribute("day", account.DayDue),
                     new XAttribute("financed", account.Financed),
                     new XAttribute("dt.first", account.FirstPaymentDate.ToShortDateString()),
                     new XAttribute("dt.org", account.OriginationsDate.ToShortDateString()),
                     new XAttribute("term", account.Terms)
                     );
        }
        
        public XElement GetXml(IAccount account, IEnumerable<ISchedule> schedules, IEnumerable<ITransaction> transactions)
        {
            return new XElement(ns + "accounting.engine",
                this.GetXml(account),
                this.GetXml(schedules),
                this.GetXml(transactions)
            );
        }
    }
}
