using Ssb.Modeling.Models.Commands;
using Ssb.Modeling.Models.Providers;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Windows.Input;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class QueueModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {
        public QueueModel()
        {
            this.SchemaName = "dbo";
            this.ClearActivator = new DoActionCommand(this.ClearActivatorAction)
            {
                IsEnabled = false,
            };
            this.CreateActivator = new DoActionCommand(this.CreateActivatorAction)
            {
                IsEnabled = true,
            };
        }
        public CommandBase ClearActivator { get; private set; }
        public CommandBase CreateActivator { get; private set; }

        private void ClearActivatorAction(object obj)
        {
            this.Activator = null;
            this.ClearActivator.IsEnabled = false;
            this.CreateActivator.IsEnabled = true;
        }
        private void CreateActivatorAction(object obj)
        {
            this.Activator = InternalActivatorProvider.New();
            this.ClearActivator.IsEnabled = true ;
            this.CreateActivator.IsEnabled = false;
        }

        // http://msdn.microsoft.com/en-us/library/ms190495.aspx
        //CREATE QUEUE [ database_name. [ schema_name ] . | schema_name. ] queue_name
        //   [ WITH
        //     [ STATUS = { ON | OFF }  [ , ] ]
        //     [ RETENTION = { ON | OFF } [ , ] ] 
        //     [ ACTIVATION (
        //         [ STATUS = { ON | OFF } , ] 
        //           PROCEDURE_NAME = [ database_name. [ schema_name ] . | schema_name. ] stored_procedure_name ,
        //           MAX_QUEUE_READERS = max_readers , 
        //           EXECUTE AS { SELF | 'user_name' | OWNER } 
        //            ) [ , ] ]
        //     [ POISON_MESSAGE_HANDLING (
        //       [ STATUS = { ON | OFF } )
        //    ]
        //     [ ON { filegroup | [ DEFAULT ] } ]
        //[ ; ]

        public string DisplayName
        {
            get { return string.Format("[{0}].[{1}]", this.SchemaName, this.QueueName); }
        }

        private string _schemaName;
        public string SchemaName
        {
            get { return this._schemaName; }
            set
            {
                this._schemaName = value;
                this.OnPropertyChanged("SchemaName");
                this.OnPropertyChanged("DisplayName");
            }
        }

        private string _queueName;
        public string QueueName
        {
            get { return this._queueName; }
            set
            {
                this._queueName = value;
                this.OnPropertyChanged("QueueName");
                this.OnPropertyChanged("DisplayName");
            }
        }

        private bool _status;
        public bool Status
        {
            get { return this._status; }
            set
            {
                this._status = value;
                this.OnPropertyChanged("Status");
            }
        }

        private bool _retention;
        public bool Retention
        {
            get { return this._retention; }
            set
            {
                this._retention = value;
                this.OnPropertyChanged("Retention");
            }
        }

        private bool _poisonMessageHandling;
        public bool PoisonMessageHandling
        {
            get { return this._poisonMessageHandling; }
            set
            {
                this._poisonMessageHandling = value;
                this.OnPropertyChanged("PoisonMessageHandling");
            }
        }

        private InternalActivatorModel _activator;
        public InternalActivatorModel Activator
        {
            get { return this._activator; }
            set
            {
                this._activator = value;

                if (value != null)
                {
                    this.ClearActivator.IsEnabled = true;
                }
                else
                {
                    this.CreateActivator.IsEnabled = true;
                }

                this.OnPropertyChanged("Activator");
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
            if (this.Activator != null)
                yield return this.Activator;
        }
    }
}
