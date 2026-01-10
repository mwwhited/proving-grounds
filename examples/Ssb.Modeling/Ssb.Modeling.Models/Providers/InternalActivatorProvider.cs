using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class InternalActivatorProvider
    {
        public static InternalActivatorModel New()
        {
            var model = new InternalActivatorModel()
            {                   
            };
            return model;
        }
    }
}
