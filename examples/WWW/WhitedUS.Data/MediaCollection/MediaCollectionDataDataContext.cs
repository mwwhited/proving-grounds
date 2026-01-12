using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.MediaCollection
{
    public partial class MediaCollectionDataDataContext
    {
        private static MediaCollectionDataDataContext _instance;
        public static MediaCollectionDataDataContext Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new MediaCollectionDataDataContext();
                return _instance;
            }
        }
    }
}
