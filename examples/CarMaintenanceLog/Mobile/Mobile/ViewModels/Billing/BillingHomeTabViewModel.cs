using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace Mobile.ViewModels.Billing
{
    internal class BillingHomeTabViewModel : ViewModelBase
    {
        public Command IncreaseCountCommand { get; }
        string countDisplay = "You clicked 0 times.";
        int count;

        public BillingHomeTabViewModel()
        {
            IncreaseCountCommand = new Command(IncreaseCount);
        }

        public string CountDisplay
        {
            get { return countDisplay; }
            set { countDisplay = value; OnPropertyChanged(); }
        }
        
        void IncreaseCount() => CountDisplay = $"You clicked {++count} times";
    }
}
