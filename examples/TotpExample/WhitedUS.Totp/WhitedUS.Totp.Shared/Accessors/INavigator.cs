using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WhitedUS.Totp.Shared.Accessors
{
    public interface INavigator
    {
        bool CanGoBack { get; }
        void GoBack();

        bool CanGoForward { get; }
        void GoForward();

        Task<bool> NavigateTo(string target);
        string CurrentPage { get; }
    }
}
