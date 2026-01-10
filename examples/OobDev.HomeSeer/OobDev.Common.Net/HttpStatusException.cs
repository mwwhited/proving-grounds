using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;

namespace OobDev.Common.Net
{
    public class HttpStatusException : Exception
    {
        public HttpStatusCode StatusCode { get; set; }

        public HttpStatusException(HttpStatusCode httpStatusCode, string message)
            : base(message)
        {
            this.StatusCode = httpStatusCode;
        }
    }
}
