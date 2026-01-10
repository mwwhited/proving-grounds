using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace OobDev.Common.ComponentModel
{
    public abstract class ViewModelBase : INotifyPropertyChanged
    {
        protected ViewModelBase(Action<Action> dispatched)
        {
            this.Dispatched = dispatched;
        }
        public Action<Action> Dispatched { get; }
        public void DispatchWork(Action work)
        {
            if (this.Dispatched == null)
                work();
            else
                this.Dispatched(work);
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            this.DispatchWork(() =>
            {
                this.PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            });
        }
    }
}
