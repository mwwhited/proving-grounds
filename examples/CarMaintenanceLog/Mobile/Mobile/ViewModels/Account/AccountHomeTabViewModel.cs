using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Forms;

namespace Mobile.ViewModels.Account
{

    public class AccountHomeTabViewModel : ViewModelBase
    {
        public Command BackCommand { get; }

        public AccountHomeTabViewModel()
        {
            BackCommand = new Command(() => ExecuteBackCommand());
        }

        private void ExecuteBackCommand()
        {

        }
    }
}
