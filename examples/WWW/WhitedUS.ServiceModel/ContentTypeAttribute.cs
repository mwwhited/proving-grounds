using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using System.ServiceModel.Channels;

namespace WhitedUS.ServiceModel
{
    /// <summary>
    /// Content Type attribute for ServiceModels (WCF)
    /// </summary>
    public class ContentTypeAttribute : Attribute, IOperationBehavior
    {
        /// <summary>
        /// Constructor for Type
        /// </summary>
        /// <param name="contentType">MIME type string</param>
        public ContentTypeAttribute(string contentType)
        {
            this.ContentType = contentType;
        }

        /// <summary>
        /// MIME type string
        /// </summary>
        public String ContentType
        {
            get;
            set;
        }

        /// <remarks />
        public void AddBindingParameters(
            OperationDescription operationDescription, 
            BindingParameterCollection bindingParameters)
        {
        }

        /// <remarks />
        public void ApplyClientBehavior(
            OperationDescription operationDescription, 
            ClientOperation clientOperation)
        {
        }

        /// <remarks />
        public void ApplyDispatchBehavior(
            OperationDescription operationDescription, 
            DispatchOperation dispatchOperation)
        {
            dispatchOperation.Formatter = new ContentTypeMessageFormatter(
                                                dispatchOperation.Formatter, 
                                                ContentType);
        }

        /// <remarks />
        public void Validate(OperationDescription operationDescription)
        {
        }
    } 
}
