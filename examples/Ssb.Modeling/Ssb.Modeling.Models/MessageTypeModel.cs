using Ssb.Modeling.Models.Commands;
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
    public class MessageTypeModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {
        // http://msdn.microsoft.com/en-us/library/ms187744.aspx
        //CREATE MESSAGE TYPE message_type_name
        //    [ AUTHORIZATION owner_name ]
        //    [ VALIDATION = {  NONE
        //                    | EMPTY 
        //                    | WELL_FORMED_XML
        //                    | VALID_XML WITH SCHEMA COLLECTION 
        //                                                    schema_collection_name
        //                   } ]
        //[ ; ]

        public MessageTypeModel()
        {
            this.ClearXmlSchemaCollection = new DoActionCommand(this.ClearXmlSchemaCollectionAction)
            {
                IsEnabled = false,
            };
        }

        public CommandBase ClearXmlSchemaCollection { get; private set; }
        private void ClearXmlSchemaCollectionAction(object obj)
        {
            this.XmlSchemaCollection = null;
            this.ClearXmlSchemaCollection.IsEnabled = false;
        }

        private string _messageTypeName;
        public string MessageTypeName
        {
            get { return this._messageTypeName; }
            set
            {
                this._messageTypeName = value;
                this.OnPropertyChanged("MessageTypeName");
            }
        }

        private ValidationType _validation;
        public ValidationType Validation
        {
            get { return this._validation; }
            set
            {
                this._validation = value;
                //if (value == ValidationType.ValidXmlWithSchemaCollection)
                //{
                //    if (this.XmlSchemaCollection == null)
                //        this._validation = ValidationType.WellFormedXml;
                //}
                //else
                //{
                //    if (this.XmlSchemaCollection != null)
                //        this.XmlSchemaCollection = null;
                //}
                this.OnPropertyChanged("Validation");
            }
        }

        private XmlSchemaCollectionModel _xmlSchemaCollection;
        public XmlSchemaCollectionModel XmlSchemaCollection
        {
            get { return this._xmlSchemaCollection; }
            set
            {
                if (this._xmlSchemaCollection != null)
                {
                    this._xmlSchemaCollection.Decrement();
                }
                this._xmlSchemaCollection = value;

                if (this._xmlSchemaCollection != null)
                {
                    this._xmlSchemaCollection.Increment();
                }

                //if (value == null)
                //{
                //    if (this.Validation == ValidationType.ValidXmlWithSchemaCollection)
                //        this.Validation = ValidationType.WellFormedXml;
                //}
                //else
                //{
                //    if (this.Validation != ValidationType.ValidXmlWithSchemaCollection)
                //        this.Validation = ValidationType.ValidXmlWithSchemaCollection;
                //    this.ClearXmlSchemaCollection.IsEnabled = true;
                //}

                this.OnPropertyChanged("XmlSchemaCollection");
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
            if (this.XmlSchemaCollection != null)
                yield return this.XmlSchemaCollection;
        }
    }
}