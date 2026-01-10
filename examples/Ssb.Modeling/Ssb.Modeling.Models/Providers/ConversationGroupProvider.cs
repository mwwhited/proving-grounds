using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class ConversationGroupProvider
    {
        private static int _id;
        public static ConversationGroupModel New()
        {
            var model = new ConversationGroupModel()
            {
                ConversationGroupName = string.Format("ConversationGroup{0}", ++ConversationGroupProvider._id),
            };
            return model;
        }
    }
}
