using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace Ssb.Modeling.Models
{
    public class InternalActivatorModel : ViewModelBase
    {
        //     [ ACTIVATION (
        //         [ STATUS = { ON | OFF } , ] 
        //           PROCEDURE_NAME = [ database_name. [ schema_name ] . | schema_name. ] stored_procedure_name ,
        //           MAX_QUEUE_READERS = max_readers , 
        //           EXECUTE AS { SELF | 'user_name' | OWNER } 
        //            ) [ , ] ]

        public InternalActivatorModel()
        {
            this.SchemaName = "dbo";
        }
        public string DisplayName
        {
            get { return string.Format("[{0}].[{1}]", this.SchemaName, this.ProcedureName); }
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

        private string _schemaName;
        public string SchemaName
        {
            get { return this._schemaName; }
            set
            {
                this._schemaName = value;
                this.OnPropertyChanged("SchemaName");
            }
        }

        private string _procedureName;
        public string ProcedureName
        {
            get { return this._procedureName; }
            set
            {
                this._procedureName = value;
                this.OnPropertyChanged("ProcedureName");
            }
        }

        private int _maxQueueReaders;
        public int MaxQueueReaders
        {
            get { return this._maxQueueReaders; }
            set
            {
                this._maxQueueReaders = value;
                this.OnPropertyChanged("MaxQueueReaders");
            }
        }
    }
}
