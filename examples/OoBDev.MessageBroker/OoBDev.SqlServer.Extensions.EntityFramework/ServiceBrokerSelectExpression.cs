using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.Expressions;
using System;
using System.Linq;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class ServiceBrokerSelectExpression : SelectExpression
    {
        public bool PerformReceive { get; private set; }
        public bool GetConversationGroup { get; private set; }
        public bool EnableQueue { get; private set; }

        public ServiceBrokerSelectExpression(
          SelectExpressionDependencies dependencies,
          RelationalQueryCompilationContext queryCompilationContext)
            : base(dependencies, queryCompilationContext)
        {
            SetCustomSelectExpressionProperties(queryCompilationContext);
        }

        public ServiceBrokerSelectExpression(
          SelectExpressionDependencies dependencies,
          RelationalQueryCompilationContext queryCompilationContext,
          string alias)
            : base(dependencies, queryCompilationContext, alias)
        {
            SetCustomSelectExpressionProperties(queryCompilationContext);
        }

        private void SetCustomSelectExpressionProperties(RelationalQueryCompilationContext queryCompilationContext)
        {
            //Note: check for receive operator here... if 0 then normal select, if once then change to receive is more than once throw an exception
            var receiveCount = queryCompilationContext.QueryAnnotations.Count(a => a.GetType() == typeof(ReceiveResultOperator));
            if (receiveCount > 1) throw new NotSupportedException($"{nameof(ServiceBrokerExtensions.Receive)} may only be used once per expression");
            this.PerformReceive = receiveCount == 1;

            var getConversationGroupCount = queryCompilationContext.QueryAnnotations.Count(a => a.GetType() == typeof(GetConversationGroupResultOperator));
            if (getConversationGroupCount > 1) throw new NotSupportedException($"{nameof(ServiceBrokerExtensions.GetConversationGroup)} may only be used once per expression");
            this.GetConversationGroup = getConversationGroupCount == 1;

            var enableQueueCount = queryCompilationContext.QueryAnnotations.Count(a => a.GetType() == typeof(EnableQueueResultOperator));
            if (enableQueueCount > 1) throw new NotSupportedException($"{nameof(ServiceBrokerExtensions.EnableQueue)} may only be used once per expression");
            this.EnableQueue = enableQueueCount == 1;


            if (new[] { this.PerformReceive, this.GetConversationGroup, this.EnableQueue }.Where(i => i).Count() > 1)
                throw new InvalidOperationException($"You may only use .{nameof(ServiceBrokerExtensions.Receive)}(...), .{nameof(ServiceBrokerExtensions.GetConversationGroup)}(...) or .{nameof(ServiceBrokerExtensions.EnableQueue)}(...) not both");

            //TODO: is it possible to detect that this operation is the outer most expression?
            //TODO: that is unless .WaitFor/WaitForAsync are used
        }
    }
}
