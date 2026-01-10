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
    public class XmlSchemaCollectionModel : ViewModelBase, IEnumerable, INotifyCollectionChanged
    {

        XNamespace ns = "http://www.w3.org/2001/XMLSchema";

        public XmlSchemaCollectionModel()
        {
            this.SchemaName = "dbo";
            this.XmlSchemas = new XmlSchemaCollection();
            this.XmlSchemas.CollectionChanged += _CollectionChanged;

            this.AddXmlSchema = new AddItemToCollectionCommand<XmlSchemaModel>(this.XmlSchemas, itemFactory: XmlSchemaProvider.New, addAlways: true);
            this.DeleteXmlSchema = new RemoveItemFromCollection<XmlSchemaModel>(this.XmlSchemas);
        }
        public ICommand AddXmlSchema { get; private set; }
        public ICommand DeleteXmlSchema { get; private set; }

        // http://msdn.microsoft.com/en-us/library/ms176009.aspx
        //CREATE XML SCHEMA COLLECTION [ <relational_schema>. ]sql_identifier AS Expression

        public string DisplayName
        {
            get { return string.Format("[{0}].[{1}]", this.SchemaName, this.XmlSchemaCollectionName); }
        }

        private string _schemaName;
        public string SchemaName // Database Schema
        {
            get { return this._schemaName; }
            set
            {
                this._schemaName = value;
                this.OnPropertyChanged("SchemaName");
                this.OnPropertyChanged("DisplayName");
            }
        }

        private string _xmlSchemaCollectionName;
        public string XmlSchemaCollectionName
        {
            get { return this._xmlSchemaCollectionName; }
            set
            {
                this._xmlSchemaCollectionName = value;
                this.OnPropertyChanged("XmlSchemaCollectionName");
                this.OnPropertyChanged("DisplayName");
            }
        }
        public XmlSchemaCollection XmlSchemas { get; private set; }

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
            foreach (var item in this.XmlSchemas)
                yield return item;
        }
    }
}
