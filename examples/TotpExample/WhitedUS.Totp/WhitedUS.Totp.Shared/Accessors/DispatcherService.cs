using System;
using System.Diagnostics.Contracts;

namespace WhitedUS.Totp.Shared.Accessors
{
    public class DispatcherService
    {
        public static void Invoke(Action action)
        {
            Contract.Ensures(action != null);
            var dipatcher = ObjectLocatorService.GetOrDefault<IDispatcher>();
            if (dipatcher == null)
                action();
            else
                dipatcher.Invoke(action);
        }
    }
}
