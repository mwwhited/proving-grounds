using Remotion.Linq.Clauses;
using Remotion.Linq.Parsing.Structure.IntermediateModel;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class GetConversationGroupExpressionNode : ResultOperatorExpressionNodeBase
    {
        public static readonly IReadOnlyCollection<MethodInfo> SupportedMethods = new[]
        {
            ServiceBrokerExtensions.GetConversationGroupMethodInfo,
        };

        public GetConversationGroupExpressionNode(MethodCallExpressionParseInfo parseInfo)
          : base(parseInfo, null, null)
        {
        }

        protected override ResultOperatorBase CreateResultOperator(ClauseGenerationContext clauseGenerationContext)
            => new GetConversationGroupResultOperator();

        public override Expression Resolve(
            ParameterExpression inputParameter,
            Expression expressionToBeResolved,
            ClauseGenerationContext clauseGenerationContext)
                => Source.Resolve(inputParameter, expressionToBeResolved, clauseGenerationContext);
    }
}
