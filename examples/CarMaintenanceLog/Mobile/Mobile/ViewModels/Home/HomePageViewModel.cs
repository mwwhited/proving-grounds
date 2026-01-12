using Mobile.Helpers;
using Mobile.Models;
using Mobile.Views.Account;
using Mobile.Views.Billing;
using Mobile.Views.Mileage;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Forms;

namespace Mobile.ViewModels.Home
{
    public class HomePageViewModel : ViewModelBase
    {
        public ObservableCollection<Item> Items { get; }
        public ObservableCollection<Grouping<string, Item>> ItemsGrouped { get; }

        public Command NavigateToMileageCommand { get; }
        public Command NavigateToBillingCommand { get; }
        public Command NavigateToAccountCommand { get; }

        public HomePageViewModel()
        {
            NavigateToMileageCommand = new Command(async () => await ExecuteNavigateToMileageCommand());
            NavigateToBillingCommand = new Command(async () => await ExecuteNavigateToBillingCommand());
            NavigateToAccountCommand = new Command(async () => await ExecuteNavigateToAccountCommand());

            Items = new ObservableCollection<Item>(new[]
            {
                new Item { Text = "Blah", Detail = "Blah" },
                new Item { Text = "Blah Blah", Detail = "Blah Blah" },
                new Item { Text = "Blue Blah", Detail = "Blah Blah Blah" },
                new Item { Text = "Blah Blah", Detail = "Blah & Blah Blah" },
                new Item { Text = "Blah Blah Blah", Detail= "Blah" },
                new Item { Text = "CCCCCC CCCCCC", Detail = "Blah Blah" },
                new Item { Text = "CCCCCC Blah", Detail = "Blah" },
                new Item { Text = "CCCCCC", Detail = "Blah" },
                new Item { Text = "CCCCCC Blah", Detail = "Blah Blah" },
                new Item { Text = "CCCCCC Blah", Detail = "Blah Blah Blah" },
                new Item { Text = "DDDDDD Blah", Detail = "Blah & Blah Blah" },
                new Item { Text = "DDDDDD Blah Blah", Detail= "Blah" },
                new Item { Text = "DDDDDD Blah", Detail = "Blah Blah" },
                new Item { Text = "EEEEEE Blah", Detail = "Blah" },
                new Item { Text = "EEEEEE", Detail = "Blah" },
                new Item { Text = "EEEEEE Blah", Detail = "Blah Blah" },
                new Item { Text = "EEEEEE Blah", Detail = "Blah Blah Blah" },
                new Item { Text = "EEEEEE Blah", Detail = "Blah & Blah Blah" },
                new Item { Text = "XXXXXXXXXX Blah Blah", Detail= "Blah" },
                new Item { Text = "XXXXXXXXXX Blah", Detail = "Blah Blah" },
                new Item { Text = "XXXXXXXXXX Blah", Detail = "Blah" },
                new Item { Text = "YYYYY", Detail = "Blah" },
                new Item { Text = "YYYYY Blah", Detail = "Blah Blah" },
                new Item { Text = "YYYYY Blah", Detail = "Blah Blah Blah" },
                new Item { Text = "YYYYY Blah", Detail = "Blah & Blah Blah" },
                new Item { Text = "1 Blah Blah", Detail= "Blah" },
                new Item { Text = "2 Blah", Detail = "Blah Blah" },
                new Item { Text = "3 Blah", Detail = "Blah" },
            });

            var sorted = from item in Items
                         orderby item.Text
                         group item by item.Text[0].ToString() into itemGroup
                         select new Grouping<string, Item>(itemGroup.Key, itemGroup);

            ItemsGrouped = new ObservableCollection<Grouping<string, Item>>(sorted);

            RefreshDataCommand = new Command(async () => await RefreshData());
        }

        async Task ExecuteNavigateToAccountCommand()
        {
            await ((NavigationPage)Application.Current.MainPage).Navigation.PushAsync(new AccountHomeTab());
        }

        async Task ExecuteNavigateToBillingCommand()
        {
            await ((NavigationPage)Application.Current.MainPage).Navigation.PushAsync(new BillingHomeTab());
        }

        async Task ExecuteNavigateToMileageCommand()
        {
            await ((NavigationPage)Application.Current.MainPage).Navigation.PushAsync(new MileageHomeTab());
        }


        public Command RefreshDataCommand { get; }

        async Task RefreshData()
        {
            IsBusy = true;
            //Load Data Here
            await Task.Delay(2000);

            IsBusy = false;
        }
    }
}
