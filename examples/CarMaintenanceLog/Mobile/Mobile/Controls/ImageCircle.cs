using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace Mobile.Controls
{
    public class ImageCircle : Image
    {
        /// <summary>
        /// Thickness property bindable property
        /// </summary>
        public static readonly BindableProperty BorderThicknessProperty = BindableProperty.Create(propertyName: nameof(BorderThickness), returnType: typeof(int), declaringType: typeof(ImageCircle), defaultValue: 0);
        /// <summary>
        /// Color property of border
        /// </summary>
        public static readonly BindableProperty BorderColorProperty = BindableProperty.Create(propertyName: nameof(BorderColor), returnType: typeof(Color), declaringType: typeof(ImageCircle), defaultValue: Color.White);
        /// <summary>
        /// Color property of fill
        /// </summary>
        public static readonly BindableProperty FillColorProperty = BindableProperty.Create(propertyName: nameof(FillColor), returnType: typeof(Color), declaringType: typeof(ImageCircle), defaultValue: Color.Transparent);

        /// <summary>
        /// Border thickness of the enclosing circle
        /// </summary>
        public int BorderThickness
        {
            get { return (int)GetValue(BorderThicknessProperty); }
            set { SetValue(BorderThicknessProperty, value); }
        }

        /// <summary>
        /// Border Color of circle image
        /// </summary>
        public Color BorderColor
        {
            get { return (Color)GetValue(BorderColorProperty); }
            set { SetValue(BorderColorProperty, value); }
        }
        
        /// <summary>
        /// Fill color of circle image
        /// </summary>
        public Color FillColor
        {
            get { return (Color)GetValue(FillColorProperty); }
            set { SetValue(FillColorProperty, value); }
        }
    }
}
