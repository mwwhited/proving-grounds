using Remotion.Linq.Clauses;
using Remotion.Linq.Parsing.Structure.IntermediateModel;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class ReceiveExpressionNode : ResultOperatorExpressionNodeBase
    {
        public static readonly IReadOnlyCollection<MethodInfo> SupportedMethods = new[]
        {
            ServiceBrokerExtensions.ReceiveMethodInfo,
        };

        public ReceiveExpressionNode(MethodCallExpressionParseInfo parseInfo)
          : base(parseInfo, null, null)
        {
        }

        protected override ResultOperatorBase CreateResultOperator(ClauseGenerationContext clauseGenerationContext)
            => new ReceiveResultOperator();

        public override Expression Resolve(
            ParameterExpression inputParameter,
            Expression expressionToBeResolved,
            ClauseGenerationContext clauseGenerationContext)
                => Source.Resolve(inputParameter, expressionToBeResolved, clauseGenerationContext);
    }
}
