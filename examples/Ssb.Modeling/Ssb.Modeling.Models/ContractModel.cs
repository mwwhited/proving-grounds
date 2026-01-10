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
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class ContractModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {
        // http://msdn.microsoft.com/en-us/library/ms178528.aspx
        //CREATE CONTRACT contract_name
        //   [ AUTHORIZATION owner_name ]
        //      (  {   { message_type_name | [ DEFAULT ] }
        //          SENT BY { INITIATOR | TARGET | ANY } 
        //       } [ ,...n] ) 
        //[ ; ]

        public ContractModel()
        {
            this.ContractMessageTypes = new ContractMessageTypeCollection();


            this.AddContractMessageType = new AddItemToCollectionCommand<ContractMessageTypeModel>(this.ContractMessageTypes, ContractMessageTypeProvider.New);

            this.DeleteContractMessageType = new RemoveItemFromCollection<ContractMessageTypeModel>(this.ContractMessageTypes);
        }

        public ContractMessageTypeCollection ContractMessageTypes { get; private set; }

        public ICommand AddContractMessageType { get; private set; }
        public ICommand DeleteContractMessageType { get; private set; }

        
        private string _contractName;
        public string ContractName
        {
            get { return this._contractName; }
            set
            {
                this._contractName = value;
                this.OnPropertyChanged("ContractName");
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
            foreach (var cmt in this.ContractMessageTypes)
                yield return cmt;
        }
    }
}
