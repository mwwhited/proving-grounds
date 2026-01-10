using Ssb.Modeling.Models.Collections;
using Ssb.Modeling.Models.Commands;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Windows.Input;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class ServiceModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {
        public ServiceModel()
        {
            this.Contracts = new ContractCollection();
            this.Contracts.CollectionChanged += _CollectionChanged;

            this.AddContract = new AddItemToCollectionCommand<ContractModel>(this.Contracts);
            this.DeleteContract = new RemoveItemFromCollection<ContractModel>(this.Contracts);
        }
        public ICommand AddContract { get; private set; }
        public ICommand DeleteContract { get; private set; }

        //CREATE SERVICE service_name
        //   [ AUTHORIZATION owner_name ]
        //   ON QUEUE [ schema_name. ]queue_name
        //   [ ( contract_name | [DEFAULT][ ,...n ] ) ]
        //[ ; ]

        public ContractCollection Contracts { get; set; }

        private string _serviceName;
        public string ServiceName
        {
            get { return this._serviceName; }
            set
            {
                this._serviceName = value;
                this.OnPropertyChanged("ServiceName");
                this.SyncEnumerable();
            }
        }

        private QueueModel _queue;
        public QueueModel Queue
        {
            get { return this._queue; }
            set
            {
                this._queue = value;
                this.OnPropertyChanged("Queue");
                this.SyncEnumerable();
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
            if (this.Queue != null)
                yield return this.Queue;
            foreach (var contract in this.Contracts)
                yield return contract;
        }
    }
}
