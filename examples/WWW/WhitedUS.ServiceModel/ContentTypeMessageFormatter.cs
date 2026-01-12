using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel.Web;
using System.ServiceModel.Channels;
using System.ServiceModel.Dispatcher;
using System.Net;

namespace WhitedUS.ServiceModel
{
    /// <summary>
    /// Message Formatter for ContentTypeAttribute
    /// </summary>
    public class ContentTypeMessageFormatter : IDispatchMessageFormatter
    {
        private IDispatchMessageFormatter formatter;
        private string contentType;
        /// <remarks />
        public ContentTypeMessageFormatter(IDispatchMessageFormatter formatter, 
                                           string contentType)
        {
            this.formatter = formatter;
            this.contentType = contentType;
        }

        /// <remarks />
        public void DeserializeRequest(Message message, object[] parameters)
        {
            formatter.DeserializeRequest(message, parameters);
        }

        /// <remarks />
        public Message SerializeReply(MessageVersion messageVersion, 
                                      object[] parameters,
                                      object result)
        {
            if (!string.IsNullOrEmpty(contentType))
                WebOperationContext.Current
                                   .OutgoingResponse
                                   .ContentType = contentType;

            return formatter.SerializeReply(messageVersion, 
                                            parameters, 
                                            result);
        }
    }
}
