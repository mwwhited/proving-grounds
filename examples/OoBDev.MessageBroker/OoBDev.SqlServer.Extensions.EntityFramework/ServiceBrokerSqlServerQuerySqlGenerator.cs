using Microsoft.EntityFrameworkCore.Query.Expressions;
using Microsoft.EntityFrameworkCore.Query.Sql;
using Microsoft.EntityFrameworkCore.SqlServer.Query.Sql.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class ServiceBrokerSqlServerQuerySqlGenerator : SqlServerQuerySqlGenerator
    {
        private TableExpression _excludeTablePrefix;

        //TODO: see if there is a safer way to do this
        private IRelationalCommandBuilder _relationalCommandBuilder
        {
            get { return typeof(DefaultQuerySqlGenerator).GetField(nameof(_relationalCommandBuilder), BindingFlags.NonPublic | BindingFlags.Instance).GetValue(this) as IRelationalCommandBuilder; }
        }
        private bool _valueConverterWarningsEnabled
        {
            get { return (bool)typeof(DefaultQuerySqlGenerator).GetField(nameof(_valueConverterWarningsEnabled), BindingFlags.NonPublic | BindingFlags.Instance).GetValue(this); }
            set { typeof(DefaultQuerySqlGenerator).GetField(nameof(_valueConverterWarningsEnabled), BindingFlags.NonPublic | BindingFlags.Instance).SetValue(this, value); }
        }

        public ServiceBrokerSqlServerQuerySqlGenerator(
          QuerySqlGeneratorDependencies dependencies,
          SelectExpression selectExpression,
          bool rowNumberPagingEnabled)
          : base(dependencies, selectExpression, rowNumberPagingEnabled)
        {
        }

        public override Expression VisitSelect(SelectExpression selectExpression)
        {
            if (selectExpression is ServiceBrokerSelectExpression sbse)
            {
                if (sbse.PerformReceive)
                {
                    return VisitReceive(sbse);
                }
                else if (sbse.GetConversationGroup)
                {
                    return VisitGetConversationGroup(sbse);
                }
                else if (sbse.EnableQueue)
                {
                    return VisitEnableQueue(sbse);
                }
            }
            return base.VisitSelect(selectExpression);
        }

        public override Expression VisitColumn(ColumnExpression columnExpression)
        {
            if (columnExpression.Table == _excludeTablePrefix)
            {
                _relationalCommandBuilder.Append(columnExpression.Name);
            }
            else
            {
                _relationalCommandBuilder.Append(SqlGenerator.DelimitIdentifier(columnExpression.Table.Alias))
                    .Append(".")
                    .Append(SqlGenerator.DelimitIdentifier(columnExpression.Name));
            }

            return columnExpression;
        }

        private Expression VisitGetConversationGroup(ServiceBrokerSelectExpression selectExpression)
        {
            var queue = GetQueue(selectExpression);

            _relationalCommandBuilder.AppendLine("DECLARE @conversationGroupID UNIQUEIDENTIFIER;")
                                     .AppendLine("GET CONVERSATION GROUP @conversationGroupID")
                                     .AppendLine("FROM ")
                                        .Append(SqlGenerator.DelimitIdentifier(queue.Schema))
                                        .Append(".")
                                        .Append(SqlGenerator.DelimitIdentifier(queue.Table))
                                        .Append(";")
                                     .AppendLine("SELECT @conversationGroupID");
            /*
            [ WAITFOR ( ]  
               GET CONVERSATION GROUP @conversation_group_id  
                  FROM <queue>  
            [ ) ] [ , TIMEOUT timeout ]  
            [ ; ]  
            */

            return selectExpression;
        }

        private Expression VisitEnableQueue(ServiceBrokerSelectExpression selectExpression)
        {
            var queue = GetQueue(selectExpression);
            _relationalCommandBuilder.Append("ALTER QUEUE ")
                                     .Append(SqlGenerator.DelimitIdentifier(queue.Schema))
                                     .Append(".")
                                     .Append(SqlGenerator.DelimitIdentifier(queue.Table))
                                     .Append(" WITH STATUS = ON");
            return selectExpression;
        }

        // https://docs.microsoft.com/en-us/sql/t-sql/statements/receive-transact-sql?view=sql-server-2017
        private Expression VisitReceive(ServiceBrokerSelectExpression selectExpression)
        {
            var queue = GetQueue(selectExpression);

            this._excludeTablePrefix = queue;

            _relationalCommandBuilder.Append("RECEIVE ");

            GenerateTop(selectExpression);

            var projectionAdded = false;

            if (selectExpression.IsProjectStar)
            {
                _relationalCommandBuilder.Append("*");
                projectionAdded = true;
            }

            if (selectExpression.Projection.Count > 0)
            {
                if (selectExpression.IsProjectStar)
                {
                    _relationalCommandBuilder.Append(", ");
                }
                this.GenerateList(selectExpression.Projection, GenerateProjection);

                projectionAdded = true;
            }

            if (!projectionAdded)
            {
                _relationalCommandBuilder.Append("1");
            }

            var oldValueConverterWarningsEnabled = _valueConverterWarningsEnabled;
            _valueConverterWarningsEnabled = true;

            _relationalCommandBuilder.AppendLine().Append($"FROM [{queue.Schema}].[{queue.Table}]");

            if (selectExpression.Predicate != null)
            {
                GeneratePredicate(selectExpression.Predicate);
            }

            _valueConverterWarningsEnabled = oldValueConverterWarningsEnabled;

            return selectExpression;
        }

        private TableExpression GetQueue(ServiceBrokerSelectExpression selectExpression)
        {
            if (selectExpression.Tables.Count != 1)
            {
                throw new InvalidOperationException("Receive must/may only use a single queue table reference");
            }
            var queue = selectExpression.Tables[0] as TableExpression
                    ?? (selectExpression.Tables[0] as SelectExpression).Tables.FirstOrDefault() as TableExpression
                    ?? throw new InvalidOperationException("invalid query for queue");

            return queue;
        }
    }
}
