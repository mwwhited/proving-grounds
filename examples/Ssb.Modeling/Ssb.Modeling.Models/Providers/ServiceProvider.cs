using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class ServiceProvider
    {
        private static int _id;
        public static ServiceModel New()
        {
            var model = new ServiceModel()
            {
                ServiceName = string.Format("Service{0}", ++ServiceProvider._id),
            };
            return model;
        }
    }
}
