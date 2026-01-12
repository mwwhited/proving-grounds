using Mobile.Abstractions;
using Mobile.Helpers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace Mobile.ViewModels
{
    public class ViewModelBase : INotifyPropertyChanged
    {
        string _propertyTitle = string.Empty;
        bool _propertyIsBusy;

        public string Title
        {
            get { return _propertyTitle; }
            set { SetProperty(ref _propertyTitle, value, "Title"); }
        }

        public bool IsBusy
        {
            get { return _propertyIsBusy; }
            set { SetProperty(ref _propertyIsBusy, value, "IsBusy"); }
        }

        public INetworkService NetworkService
        {
            get { return DependencyService.Get<INetworkService>(); } //platform implementation
        }

        public IAppLogger LogService
        {
            get { return ServiceLocator.Instance.Resolve<IAppLogger>(); }
        }

        public IErrorService ErrorService
        {
            get { return ServiceLocator.Instance.Resolve<IErrorService>(); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void SetProperty<T>(ref T store, T value, string propName, Action onChanged = null)
        {
            if (EqualityComparer<T>.Default.Equals(store, value))
                return;
            store = value;

            onChanged?.Invoke();

            OnPropertyChanged(propName);
        }

        public void OnPropertyChanged([CallerMemberName] string propName = "") => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));
    }
}
