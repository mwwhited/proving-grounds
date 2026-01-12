using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.Chatty
{
    public partial class ChattyDataDataContext
    {
        public ChattyDataDataContext() :
            base(global::WhitedUS.Data.Properties
                                      .Settings.Default
                                      .ChattyDataConnectionString, 
                 mappingSource)
		{
			OnCreated();
		}
    }
}
