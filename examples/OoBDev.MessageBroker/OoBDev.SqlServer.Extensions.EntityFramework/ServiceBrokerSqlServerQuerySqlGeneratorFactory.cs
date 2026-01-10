using Microsoft.EntityFrameworkCore.Query.Expressions;
using Microsoft.EntityFrameworkCore.Query.Sql;
using Microsoft.EntityFrameworkCore.SqlServer.Infrastructure.Internal;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class ServiceBrokerSqlServerQuerySqlGeneratorFactory : QuerySqlGeneratorFactoryBase
    {
        private readonly ISqlServerOptions _sqlServerOptions;

        public ServiceBrokerSqlServerQuerySqlGeneratorFactory(
          QuerySqlGeneratorDependencies dependencies,
          ISqlServerOptions sqlServerOptions)
            : base(dependencies)
        {
            _sqlServerOptions = sqlServerOptions;
        }

        public override IQuerySqlGenerator CreateDefault(SelectExpression selectExpression)
          => new ServiceBrokerSqlServerQuerySqlGenerator(
            Dependencies,
            selectExpression,
            _sqlServerOptions.RowNumberPagingEnabled);
    }
}