namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class MessageType : IMessageType
    {
        public string Name { get; internal set; }
        public MessageValidationType ValidationType { get; internal set; }

        /*
            CREATE MESSAGE TYPE message_type_name  
                [ AUTHORIZATION owner_name ]  
                [ VALIDATION = {  NONE  
                                | EMPTY   
                                | WELL_FORMED_XML  
                                | VALID_XML WITH SCHEMA COLLECTION schema_collection_name  
                               } ] 
         */
    }
}