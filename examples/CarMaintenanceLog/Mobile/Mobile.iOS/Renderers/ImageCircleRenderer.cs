using System;
using Foundation;
using Mobile.iOS.Renderers;
using Mobile.Controls;
using Xamarin.Forms;
using System.Diagnostics;
using Xamarin.Forms.Platform.iOS;
using System.ComponentModel;
using System.Threading.Tasks;

[assembly: ExportRenderer(typeof(ImageCircle), typeof(ImageCircleRenderer))]
namespace Mobile.iOS.Renderers
{
    [Preserve(AllMembers = true)]
    public class ImageCircleRenderer : ImageRenderer
    {
        public async static void InitBecause() => await Task.Run(() => { var temp = DateTime.Now; });

        protected override void OnElementChanged(ElementChangedEventArgs<Image> e)
        {
            base.OnElementChanged(e);
            if (Element == null)
                return;

            CreateCircle();
        }

        protected override void OnElementPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(sender, e);
            if (e.PropertyName == VisualElement.HeightProperty.PropertyName ||
                e.PropertyName == VisualElement.WidthProperty.PropertyName ||
              e.PropertyName == ImageCircle.BorderColorProperty.PropertyName ||
              e.PropertyName == ImageCircle.BorderThicknessProperty.PropertyName ||
              e.PropertyName == ImageCircle.FillColorProperty.PropertyName)
            {
                CreateCircle();
            }
        }

        private void CreateCircle()
        {
            try
            {
                var min = Math.Min(Element.Width, Element.Height);
                Control.Layer.CornerRadius = (float)(min / 2.0);
                Control.Layer.MasksToBounds = false;
                Control.Layer.BorderColor = ((ImageCircle)Element).BorderColor.ToCGColor();
                Control.Layer.BorderWidth = ((ImageCircle)Element).BorderThickness;
                Control.BackgroundColor = ((ImageCircle)Element).FillColor.ToUIColor();
                Control.ClipsToBounds = true;
            }
            catch (Exception ex)
            {
                //TODO: Change to some general error reporting service or app insights
                Debug.WriteLine($@"Error creating ImageCircle: {ex}");
            }
        }
    }
}