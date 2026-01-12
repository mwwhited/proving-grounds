using Mobile.ViewModels.Home;
using Mobile.Views.Entry;
using Mobile.Views.Home;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace Mobile.ViewModels.Entry
{
    public class EntryPageViewModel : ViewModelBase
    {
        public Command EnterAppCommand { get; }
        public Command EnterTabsCommand { get; }
        public Command EnterCarouselCommand { get; }

        public EntryPageViewModel()
        {
            EnterAppCommand = new Command(() => ExecuteEnterAppCommand());
            EnterTabsCommand = new Command(() => ExecuteEnterTabsCommand());
            EnterCarouselCommand = new Command(() => ExecuteEnterCarouselCommand());
        }

        private void ExecuteEnterCarouselCommand()
        {
            Application.Current.MainPage = new HomeCarousel();
        }

        private void ExecuteEnterTabsCommand()
        {
            Application.Current.MainPage = new HomeTabbed();
        }

        private void ExecuteEnterAppCommand()
        {
            Application.Current.MainPage = new NavigationPage(new HomePage(new HomePageViewModel()));
        }
    }
}
