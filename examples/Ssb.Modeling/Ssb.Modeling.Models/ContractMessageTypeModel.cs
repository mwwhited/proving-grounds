using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class ContractMessageTypeModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {
        private MessageTypeModel _messageType;
        public MessageTypeModel MessageType
        {
            get { return this._messageType; }
            set
            {
                if (this._messageType != null)
                {
                    this._messageType.Decrement();
                }

                this._messageType = value;

                if (this._messageType != null)
                {
                    this._messageType.Increment();
                }

                this.OnPropertyChanged("MessageType");
            }
        }

        private MessageSender _sentBy;
        public MessageSender SentBy
        {
            get { return this._sentBy; }
            set
            {
                this._sentBy = value;
                this.OnPropertyChanged("SentBy");
            }
        }

        public event NotifyCollectionChangedEventHandler CollectionChanged;
        private void SyncEnumerable()
        {
            if (this.CollectionChanged != null)
                this.CollectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
        }
        private void _CollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            this.SyncEnumerable();
        }

        public IEnumerator GetEnumerator()
        {
            if (this.MessageType !=null)
                yield return this.MessageType;
        }
    }
}
