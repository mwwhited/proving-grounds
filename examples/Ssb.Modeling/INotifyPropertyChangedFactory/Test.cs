using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace INotifyPropertyChangedFactory
{
    public class Test
    {
        [Notifiable]
        public virtual string Property1 { get; set; }
        [Notifiable("Property2")]
        public virtual string Property2 { get; set; }
        [Notifiable("Property2")]
        public virtual string Property3 { get; set; }
        [Notifiable("Property4", "Property1")]
        public virtual string Property4 { get; set; }
    }

    //public class Rep : Test, INotifyPropertyChanged
    //{
    //    public override string Property1
    //    {
    //        get { return base.Property1; }
    //        set
    //        {
    //            base.Property1 = value;
    //            this.OnPropertyChanged("Property1");
    //        }
    //    }

    //    public event PropertyChangedEventHandler PropertyChanged;
    //    protected virtual void OnPropertyChanged(string propName)
    //    {
    //        if (PropertyChanged != null)
    //        {
    //            PropertyChanged(this, new PropertyChangedEventArgs(propName));
    //        }
    //    }
    //}
}
