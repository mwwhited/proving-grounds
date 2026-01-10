using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class XmlSchemaCollectionProvider
    {
        private static int _id;
        public static XmlSchemaCollectionModel New()
        {
            var model = new XmlSchemaCollectionModel()
            {
                XmlSchemaCollectionName = string.Format("XmlSchemaCollection{0}", ++XmlSchemaCollectionProvider._id),
            };
            return model;
        }
    }
}
