using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mobile.Models
{
    public class Item
    {
        public string Text { get; set; }
        public string Detail { get; set; }

        public override string ToString() => Text;
    }
}
