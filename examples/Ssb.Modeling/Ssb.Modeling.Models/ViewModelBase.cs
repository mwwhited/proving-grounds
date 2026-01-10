using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;

namespace Ssb.Modeling.Models
{
    public abstract class ViewModelBase : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propName));
            }
            Debug.WriteLine("propName: {0}:>{1}", propName, this);
        }

        private int _refCount;
        public void Increment()
        {
            this._refCount++;
        }

        public void Decrement()
        {
            if (this._refCount > 0)
                this._refCount--;
            if (this._refCount < 0)
                this._refCount = 0;
        }

        public bool IsReferenced()
        {
            return this._refCount > 0;
        }
    }
}
