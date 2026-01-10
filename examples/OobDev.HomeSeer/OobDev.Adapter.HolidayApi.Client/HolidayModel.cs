using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Adapter.HolidayApi.Client
{
    [DebuggerDisplay("{Country}: {Name} ({Date})")]
    public class HolidayModel
    {
        public HolidayModel(JToken json)
        {
            this.Name = (string)json["name"];
            this.Country = (string)json["country"];
            this.Date = (DateTime)json["date"];
        }

        public string Name { get;  }
        public string Country { get;  }
        public DateTime Date { get; }
    }
}
