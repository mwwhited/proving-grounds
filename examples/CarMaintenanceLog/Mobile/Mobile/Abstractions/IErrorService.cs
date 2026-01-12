using System;
using System.Threading.Tasks;

namespace Mobile.Abstractions
{
    public interface IErrorService
    {
        Task AlertFromException(Exception ex, bool showDetails, string title);
    }
}
