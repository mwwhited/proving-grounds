using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Ssb.Modeling.Models
{
    public class ConversationModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {

        private readonly ConversationServiceModel _RefInitiator = new ConversationServiceModel("Initiator");
        private readonly ConversationServiceModel _RefTarget = new ConversationServiceModel("Target");

        public ConversationModel()
        {
            //this.Initiator = new ServiceModel();
            //this.Target = new ServiceModel();
        }

        private string _conversationName;
        public string ConversationName
        {
            get { return this._conversationName; }
            set
            {
                this._conversationName = value;
                this.OnPropertyChanged("ConversationName");
            }
        }

        private ServiceModel _initiator;
        public ServiceModel Initiator
        {
            get { return this._initiator; }
            set
            {
                this._initiator = value;
                this._RefInitiator.Service = this._initiator;
                this.OnPropertyChanged("Initiator");
                this.SyncEnumerable();
            }
        }


        private ServiceModel _target;
        public ServiceModel Target
        {
            get { return this._target; }
            set
            {
                this._target = value;
                this._RefTarget.Service = this._target;
                this.OnPropertyChanged("Target");
                this.SyncEnumerable();
            }
        }

        public event NotifyCollectionChangedEventHandler CollectionChanged;
        private void SyncEnumerable()
        {
            if (this.CollectionChanged != null)
                this.CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
            Debug.WriteLine("propName: {0}:>{1}", "SyncEnumerable", this);
        }
        private void _CollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            this.SyncEnumerable();
        }

        public IEnumerator GetEnumerator()
        {
            yield return this._RefInitiator;
            yield return this._RefTarget;
        }
    }
}
