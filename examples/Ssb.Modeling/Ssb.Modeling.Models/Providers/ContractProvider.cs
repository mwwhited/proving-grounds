using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class ContractProvider
    {
        private static int _id;
        public static ContractModel New()
        {
            var model = new ContractModel()
            {
                ContractName = string.Format("Contract{0}", ++ContractProvider._id),
            };
            return model;
        }
    }
}
