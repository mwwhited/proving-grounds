using Ssb.Modeling.Models.Collections;
using Ssb.Modeling.Models.Commands;
using Ssb.Modeling.Models.Providers;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Windows.Input;

namespace Ssb.Modeling.Models
{
    public class ProjectModel : ViewModelBase, IEnumerable //, INotifyCollectionChanged
    {
        public ProjectModel()
        {
            this.XmlSchemaCollections = new XmlSchemaCollectionCollection();
            this.MessageTypes = new MessageTypeCollection();
            this.Contracts = new ContractCollection();
            this.Queues = new QueueCollection();
            this.Services = new ServiceCollection();
            this.Conversations = new ConversationCollection();
            this.ConversationGroups = new ConversationGroupCollection();

            this.SyncEnumerable();
            
            this.AddXmlSchemaCollection = new AddItemToCollectionCommand<XmlSchemaCollectionModel>(this.XmlSchemaCollections, XmlSchemaCollectionProvider.New);
            this.AddMessageType = new AddItemToCollectionCommand<MessageTypeModel>(this.MessageTypes, MessageTypeProvider.New);
            this.AddContract = new AddItemToCollectionCommand<ContractModel>(this.Contracts, ContractProvider.New);
            this.AddQueue = new AddItemToCollectionCommand<QueueModel>(this.Queues, QueueProvider.New);
            this.AddService = new AddItemToCollectionCommand<ServiceModel>(this.Services, ServiceProvider.New);
            this.AddConversation = new AddItemToCollectionCommand<ConversationModel>(this.Conversations, ConversationProvider.New);
            this.AddConversationGroup = new AddItemToCollectionCommand<ConversationGroupModel>(this.ConversationGroups, ConversationGroupProvider.New);

            this.DeleteXmlSchemaCollection = new RemoveItemFromCollection<XmlSchemaCollectionModel>(this.XmlSchemaCollections);
            this.DeleteMessageType = new RemoveItemFromCollection<MessageTypeModel>(this.MessageTypes);
            this.DeleteContract = new RemoveItemFromCollection<ContractModel>(this.Contracts);
            this.DeleteQueue = new RemoveItemFromCollection<QueueModel>(this.Queues);
            this.DeleteService = new RemoveItemFromCollection<ServiceModel>(this.Services);
            this.DeleteConversation = new RemoveItemFromCollection<ConversationModel>(this.Conversations);
            this.DeleteConversationGroup = new RemoveItemFromCollection<ConversationGroupModel>(this.ConversationGroups);
        }

        private string _projectName;
        public string ProjectName
        {
            get { return this._projectName; }
            set
            {
                this._projectName = value;
                this.OnPropertyChanged("ProjectName");
            }
        }

        public XmlSchemaCollectionCollection XmlSchemaCollections { get; private set; }
        public MessageTypeCollection MessageTypes { get; private set; }
        public ContractCollection Contracts { get; private set; }
        public QueueCollection Queues { get; private set; }
        public ServiceCollection Services { get; private set; }
        public ConversationCollection Conversations { get; private set; }
        public ConversationGroupCollection ConversationGroups { get; private set; }

        public ICommand AddXmlSchemaCollection { get; private set; }
        public ICommand AddMessageType { get; private set; }
        public ICommand AddContract { get; private set; }
        public ICommand AddQueue { get; private set; }
        public ICommand AddService { get; private set; }
        public ICommand AddConversation { get; private set; }
        public ICommand AddConversationGroup { get; private set; }

        public ICommand DeleteXmlSchemaCollection { get; private set; }
        public ICommand DeleteMessageType { get; private set; }
        public ICommand DeleteContract { get; private set; }
        public ICommand DeleteQueue { get; private set; }
        public ICommand DeleteService { get; private set; }
        public ICommand DeleteConversation { get; private set; }
        public ICommand DeleteConversationGroup { get; private set; }

        public IEnumerator GetEnumerator()
        {
            yield return this.ConversationGroups;
            yield return this.Conversations;
            yield return this.Services;
            yield return this.Queues;
            yield return this.Contracts;
            yield return this.MessageTypes;
            yield return this.XmlSchemaCollections;
        }

        public event NotifyCollectionChangedEventHandler CollectionChanged;
        private void SyncEnumerable()
        {
            if (this.CollectionChanged != null)
                this.CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }
    }
}
