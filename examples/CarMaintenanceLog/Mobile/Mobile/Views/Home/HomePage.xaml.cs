using Mobile.Helpers;
using Mobile.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using Mobile.ViewModels.Home;

namespace Mobile.Views.Home
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class HomePage : ContentPage
    {
        private HomePageViewModel _viewModel;
        
        public HomePage(HomePageViewModel homePageViewModel)
        {
            InitializeComponent();
            _viewModel = homePageViewModel;
            BindingContext = _viewModel;
        }

        void Handle_ItemTapped(object sender, ItemTappedEventArgs e) => ((ListView)sender).SelectedItem = null;

        async void Handle_ItemSelected(object sender, SelectedItemChangedEventArgs e)
        {
            if (e.SelectedItem == null)
                return;

            await DisplayAlert("Selected", e.SelectedItem.ToString(), "OK");

            //Deselect Item
            ((ListView)sender).SelectedItem = null;
        }
    }
}
