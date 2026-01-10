using Ssb.Modeling.Models.Collections;
using Ssb.Modeling.Models.Commands;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class ConversationGroupModel : ViewModelBase
    {
        public ConversationGroupModel()
        {
            this.Conversations = new ConversationCollection();

            this.AddConversation = new AddItemToCollectionCommand<ConversationModel>(this.Conversations);
            this.DeleteConversation = new RemoveItemFromCollection<ConversationModel>(this.Conversations);
        }
        public ICommand AddConversation { get; private set; }
        public ICommand DeleteConversation { get; private set; }

        public ConversationCollection Conversations { get; private set; }

        private string _conversationGroupName;
        public string ConversationGroupName
        {
            get { return this._conversationGroupName; }
            set
            {
                this._conversationGroupName = value;
                this.OnPropertyChanged("ConversationGroupName");
            }
        }
    }
}
