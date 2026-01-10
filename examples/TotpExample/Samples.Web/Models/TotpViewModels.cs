using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Samples.Web.Models
{
    public class TotpEnabledModel
    {
        public bool IsEnabled { get; set; }
    }
    public class TotpShareModel
    {
        public string Secret { get; set; }
        public string Uri { get; set; }
    }
}