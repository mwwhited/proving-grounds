using System;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Remotion.Linq.Parsing.Structure;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class ServiceBrokerMethodInfoBasedNodeTypeRegistryFactory : DefaultMethodInfoBasedNodeTypeRegistryFactory
    {
        public override INodeTypeProvider Create()
        {
            RegisterMethods(ReceiveExpressionNode.SupportedMethods, typeof(ReceiveExpressionNode));
            RegisterMethods(GetConversationGroupExpressionNode.SupportedMethods, typeof(GetConversationGroupExpressionNode));
            RegisterMethods(EnableQueueExpressionNode.SupportedMethods, typeof(EnableQueueExpressionNode));
            return base.Create();
        }
    }
}