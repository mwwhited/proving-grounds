using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class QueueProvider
    {
        private static int _id;
        public static QueueModel New()
        {
            var model = new QueueModel()
            {
                QueueName = string.Format("Queue{0}", ++QueueProvider._id),
                Status = true,
            };
            return model;
        }
    }
}
