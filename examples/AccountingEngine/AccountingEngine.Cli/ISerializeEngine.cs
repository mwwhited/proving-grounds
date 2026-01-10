using System.Collections.Generic;
using System.Xml.Linq;

namespace AccountingEngine.Cli
{
    public interface ISerializeEngine
    {
        XElement GetXml(IAccount account);
        XElement GetXml(ISchedule schedule);
        XElement GetXml(ITransaction transaction);

        XElement GetXml(IAccount account, IEnumerable<ISchedule> schedules, IEnumerable<ITransaction> transactions);
    }
}