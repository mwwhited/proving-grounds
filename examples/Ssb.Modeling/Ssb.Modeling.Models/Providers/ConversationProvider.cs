using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class ConversationProvider
    {
        private static int _id;
        public static ConversationModel New()
        {
            var model = new ConversationModel()
            {
                ConversationName = string.Format("Conversation{0}", ++ConversationProvider._id),
            };
            return model;
        }
    }
}
