using Remotion.Linq.Clauses;
using Remotion.Linq.Parsing.Structure.IntermediateModel;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class EnableQueueExpressionNode : ResultOperatorExpressionNodeBase
    {
        public static readonly IReadOnlyCollection<MethodInfo> SupportedMethods = new[]
        {
            ServiceBrokerExtensions.EnableQueueMethodInfo,
        };

        public EnableQueueExpressionNode(MethodCallExpressionParseInfo parseInfo)
          : base(parseInfo, null, null)
        {
        }

        protected override ResultOperatorBase CreateResultOperator(ClauseGenerationContext clauseGenerationContext)
            => new EnableQueueResultOperator();

        public override Expression Resolve(
            ParameterExpression inputParameter,
            Expression expressionToBeResolved,
            ClauseGenerationContext clauseGenerationContext)
                => Source.Resolve(inputParameter, expressionToBeResolved, clauseGenerationContext);
    }
}
