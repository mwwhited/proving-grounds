using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.MediaCollection
{
    public partial class MediaType
    {
        private CodeType _CodeType;
        public CodeType CodeType
        {
            get
            {
                //MAGIC: refactor this
                if ((_CodeType == null && _CodeTypeID.HasValue) ||
                    _CodeType != null && _CodeTypeID.HasValue && _CodeType.CodeTypeID != _CodeTypeID.Value)
                    _CodeType = MediaCollectionDataDataContext.Instance.CodeTypes.Where(mt => mt.CodeTypeID == _CodeTypeID.Value).FirstOrDefault();
                else if (_CodeType != null && !_CodeTypeID.HasValue)
                    _CodeType = null;
                return _CodeType;
            }
            set
            {
                if (_CodeType != value)
                    _CodeType = value;

                if (_CodeType != null && _CodeType.CodeTypeID != _CodeTypeID.Value)
                    _CodeTypeID = _CodeType.CodeTypeID;
                else if (_CodeType == null && _CodeTypeID.HasValue)
                    _CodeTypeID = null;
            }
        }

        public override string ToString()
        {
            return Name;
        }
    }
}
