using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.Expressions;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class ServiceBrokerSelectExpressionFactory : SelectExpressionFactory
    {
        public ServiceBrokerSelectExpressionFactory(SelectExpressionDependencies dependencies)
            : base(dependencies)
        {
        }

        public override SelectExpression Create(RelationalQueryCompilationContext queryCompilationContext)
          => new ServiceBrokerSelectExpression(Dependencies, queryCompilationContext);

        public override SelectExpression Create(RelationalQueryCompilationContext queryCompilationContext, string alias)
          => new ServiceBrokerSelectExpression(Dependencies, queryCompilationContext, alias);
    }
}