using System;
using System.Collections.Generic;
using System.Data.Services;
using System.Linq;
using System.Text;
using WhitedUS.PhotoStore.Data;

namespace WhitedUS.PhotoStore.ServiceModel
{
    public class PhotoStoreDataService : DataService<PhotoStoreEntities>
    {
        public static void InitializeService(DataServiceConfiguration config)
        {
            // Set the access rules of feeds exposed by the data service, which is
            // based on the requirements of client applications.
            config.SetEntitySetAccessRule("*", EntitySetRights.All);

            // Paging requires v2 of the OData protocol.
            config.DataServiceBehavior.MaxProtocolVersion = System.Data.Services.Common.DataServiceProtocolVersion.V2;
        }
    }
}
