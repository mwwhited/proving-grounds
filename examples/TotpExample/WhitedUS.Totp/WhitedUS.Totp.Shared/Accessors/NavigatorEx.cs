using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;

namespace WhitedUS.Totp.Shared.Accessors
{
    public static class NavigatorEx
    {
        public static void StoreCurrent(this INavigator navigator)
        {
            Contract.Requires(navigator != null);

            var valueStore = ObjectLocatorService.Get<ISettingsStore>();
            if (valueStore != null)
                valueStore.Add(Globals.Keys.CurrentPage, navigator.CurrentPage);
        }

        public static void RaiseCanGoBackChanged(this INavigator navigator)
        {
            Contract.Requires(navigator != null);


        }
    }
}
