using Mobile.Abstractions;
using Mobile.Services;
using System;
using System.Threading.Tasks;
using Xamarin.Forms;

[assembly: Dependency(typeof(ErrorService))]
namespace Mobile.Services
{
    public class ErrorService : IErrorService
    {
        public async Task AlertFromException(Exception ex, bool showDetails = false, string title = Globals.DEFAULT_ERRORALERT_TITLE)
        {
            await Application.Current.MainPage.DisplayAlert(
                $@"{title}",
                $@"Eew, something went wrong. Sorry about that.{Environment.NewLine}" +
                ((showDetails) ? $"Here is some nerdy info if you care.{Environment.NewLine}{ex.Message}" : string.Empty),
                "Maybe later!");
        }
    }
}
