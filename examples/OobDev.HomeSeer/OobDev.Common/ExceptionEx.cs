using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common
{
    public static class ExceptionEx
    {
        public static Exception InnerMost(this Exception exception)
        {
            Contract.Requires(exception != null);
            Contract.Ensures(Contract.Result<Exception>() != null);

            if (exception.InnerException == null)
                return exception;
            else
                return exception.InnerException.InnerMost();
        }
    }
}
