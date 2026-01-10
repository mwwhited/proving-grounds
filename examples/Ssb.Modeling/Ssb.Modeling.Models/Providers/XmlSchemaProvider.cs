using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public class XmlSchemaProvider
    {
        public static readonly string DefaultSchmea = @"<xs:schema id='XMLSchema1'
    targetNamespace='http://tempuri.org/XMLSchema1.xsd'
    elementFormDefault='qualified'
    xmlns='http://tempuri.org/XMLSchema1.xsd'
    xmlns:xs='http://www.w3.org/2001/XMLSchema'
>
</xs:schema>";
        public static XmlSchemaModel New()
        {
            var model = new XmlSchemaModel()
            {
                XmlSchema = XmlSchemaProvider.DefaultSchmea,
            };
            return model;
        }
    }
}
