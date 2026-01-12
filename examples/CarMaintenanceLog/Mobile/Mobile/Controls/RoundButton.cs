using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace Mobile.Controls
{
    public class RoundButton : Button
    {
        public static readonly BindableProperty CornerRadiusProperty = BindableProperty.Create("CornerRadius", typeof(double), typeof(RoundButton), 5d, BindingMode.TwoWay);

        public double CornerRadius
        {
            get { return (double)GetValue(CornerRadiusProperty); }
            set
            {
                OnPropertyChanging(nameof(CornerRadius));
                SetValue(CornerRadiusProperty, value);
                OnPropertyChanged(nameof(CornerRadius));
            }
        }
    }
}
