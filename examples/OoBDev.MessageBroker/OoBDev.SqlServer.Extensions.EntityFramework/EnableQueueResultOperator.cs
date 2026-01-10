using Microsoft.EntityFrameworkCore.Query.ResultOperators;
using Remotion.Linq;
using Remotion.Linq.Clauses;
using Remotion.Linq.Clauses.ResultOperators;
using Remotion.Linq.Clauses.StreamedData;
using System;
using System.Linq.Expressions;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class EnableQueueResultOperator : SequenceTypePreservingResultOperatorBase, IQueryAnnotation
    {
        public IQuerySource QuerySource { get; set; }
        public QueryModel QueryModel { get; set; }

        public override ResultOperatorBase Clone(CloneContext cloneContext) => new ReceiveResultOperator();
        public override StreamedSequence ExecuteInMemory<T>(StreamedSequence input) => input;
        public override void TransformExpressions(Func<Expression, Expression> transformation) { }
    }
}