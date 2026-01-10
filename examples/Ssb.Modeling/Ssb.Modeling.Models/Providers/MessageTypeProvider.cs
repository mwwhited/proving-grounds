using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class MessageTypeProvider
    {
        private static int _id;
        public static MessageTypeModel New()
        {
            var model = new MessageTypeModel()
            {
                MessageTypeName = string.Format("MessageType{0}", ++MessageTypeProvider._id),
            };
            return model;
        }
    }
}
