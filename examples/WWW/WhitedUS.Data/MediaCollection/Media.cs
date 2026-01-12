using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.MediaCollection
{
    public partial class Media
    {
        private MediaType _MediaType;
        public MediaType MediaType
        {
            get
            {
                //MAGIC::  refactor please
                if ((_MediaType == null && _MediaTypeID.HasValue) ||
                    _MediaType != null && _MediaTypeID.HasValue && _MediaType.MediaTypeID != _MediaTypeID.Value)
                    _MediaType = MediaCollectionDataDataContext.Instance.MediaTypes.Where(mt => mt.MediaTypeID == _MediaTypeID.Value).FirstOrDefault();
                else if (_MediaType != null && !_MediaTypeID.HasValue)
                    _MediaType = null;
                return _MediaType;
            }
            set
            {
                if (_MediaType != value)
                    _MediaType = value;

                if (_MediaType != null && _MediaType.MediaTypeID != _MediaTypeID.Value)
                    _MediaTypeID = _MediaType.MediaTypeID;
                else if (_MediaType == null && _MediaTypeID.HasValue)
                    _MediaTypeID = null;                    
            }
        }

        public string DetailLinkUrl
        {
            get
            {
                if (!string.IsNullOrEmpty(Code) &&
                    MediaType != null &&
                    MediaType.CodeType != null &&
                    !string.IsNullOrEmpty(MediaType.CodeType.BaseUrl))
                    return MediaType.CodeType.BaseUrl + Code;
                return null;
            }
        }

        public override string ToString()
        {
            return Title; 
        }
    }
}
