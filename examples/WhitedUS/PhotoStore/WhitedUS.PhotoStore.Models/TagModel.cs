using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.PhotoStore.Models
{
    public class TagModel
    {
        public int TagID { get; set; }
        public string Label { get; set; }
        public int Count { get; set; }
        public double Percent { get; set; }
        public int Tier { get; set; }
        public int Total { get; set; }

        public string TagClass
        {
            get
            {
                var result = this.Percent;
                if (result <= 1)
                    return "tag-weight-1";
                if (result <= 4)
                    return "tag-weight-2";
                if (result <= 8)
                    return "tag-weight-3";
                if (result <= 12)
                    return "tag-weight-4";
                if (result <= 18)
                    return "tag-weight-5";
                if (result <= 30)
                    return "tag-weight-6";
                return result <= 50 ? "tag-weight-7" : "";
            }
        }

    }
}
