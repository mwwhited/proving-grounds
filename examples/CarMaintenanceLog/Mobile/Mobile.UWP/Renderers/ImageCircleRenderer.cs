using Xamarin.Forms.Platform.UWP;
using System;
using System.IO;
using Windows.ApplicationModel;
using Windows.Storage;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Imaging;
using Windows.UI.Xaml.Shapes;
using Xamarin.Forms;
using Mobile.Controls;
using Mobile.UWP.Renderers;
using System.Threading.Tasks;
using System.Diagnostics;

[assembly: ExportRenderer(typeof(ImageCircle), typeof(ImageCircleRenderer))]
namespace Mobile.UWP.Renderers
{
    public class ImageCircleRenderer : ViewRenderer<Image, Ellipse>
    {
        Xamarin.Forms.ImageSource _imageSource = null;

        /// <summary>
        /// So the dependency service picks this renderer up... also so optimizations don't strip the "unused" class
        /// </summary>
        public async static void Init() => await Task.Run(() => { var temp = DateTime.Now; });
        
		protected override void OnElementChanged(ElementChangedEventArgs<Image> e)
        {
            base.OnElementChanged(e);
            if (e.OldElement != null || Element == null)
                return;

            SetNativeControl(new Ellipse());
        }

        protected async override void OnElementPropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            base.OnElementPropertyChanged(sender, e);

            if (Control == null)
                return;
            
            var min = Math.Min(Element.Width, Element.Height);
            if (min / 2.0f <= 0)
                return;

            try
            {
                Control.Width = min;
                Control.Height = min;

                var element = (ImageCircle)Element;
                var color = element.FillColor; // Fill background color
                Control.Fill = new SolidColorBrush(Windows.UI.Color.FromArgb(
                    (byte)(color.A * 255),
                    (byte)(color.R * 255),
                    (byte)(color.G * 255),
                    (byte)(color.B * 255))); //white at full alias

                // Fill stroke
                color = element.BorderColor;
                Control.StrokeThickness = element.BorderThickness;
                Control.Stroke = new SolidColorBrush(Windows.UI.Color.FromArgb(
                   (byte)(color.A * 255),
                   (byte)(color.R * 255),
                   (byte)(color.G * 255),
                   (byte)(color.B * 255))); //white at full alias

                var force = e.PropertyName == VisualElement.XProperty.PropertyName || //Size, position, translation etc. property change checks
                    e.PropertyName == VisualElement.YProperty.PropertyName ||
                    e.PropertyName == VisualElement.WidthProperty.PropertyName ||
                    e.PropertyName == VisualElement.HeightProperty.PropertyName ||
                    e.PropertyName == VisualElement.ScaleProperty.PropertyName ||
                    e.PropertyName == VisualElement.TranslationXProperty.PropertyName ||
                    e.PropertyName == VisualElement.TranslationYProperty.PropertyName ||
                    e.PropertyName == VisualElement.RotationYProperty.PropertyName ||
                    e.PropertyName == VisualElement.RotationXProperty.PropertyName ||
                    e.PropertyName == VisualElement.RotationProperty.PropertyName ||
                    e.PropertyName == VisualElement.AnchorXProperty.PropertyName ||
                    e.PropertyName == VisualElement.AnchorYProperty.PropertyName;

                
                if (_imageSource == element.Source && !force) //already set
                    return;

                _imageSource = element.Source;

                BitmapImage bitmapImage = null;
                
                if (_imageSource is FileImageSource)// Handle file images
                {
                    var fi = Element.Source as FileImageSource;
                    var file = System.IO.Path.Combine(Package.Current.InstalledLocation.Path, fi.File);
                    var folder = await StorageFolder.GetFolderFromPathAsync(System.IO.Path.GetDirectoryName(file));

                    using (var s = await folder.OpenStreamForReadAsync(System.IO.Path.GetFileName(file)))
                    {
                        var memStream = new MemoryStream();
                        await s.CopyToAsync(memStream);
                        memStream.Position = 0;
                        bitmapImage = new BitmapImage();
                        bitmapImage.SetSource(memStream.AsRandomAccessStream());
                    }
                }
                else if (_imageSource is UriImageSource) //uri images
                {
                    bitmapImage = new BitmapImage((Element.Source as UriImageSource).Uri);
                }
                else if (_imageSource is StreamImageSource) //stream images
                {
                    var handler = new StreamImageSourceHandler();
                    var imageSource = await handler.LoadImageAsync(_imageSource);

                    if (imageSource != null)
                        Control.Fill = new ImageBrush { ImageSource = imageSource, Stretch = Stretch.UniformToFill, };
                    
                    return;
                }

                if (bitmapImage != null) //set the fill from the image we just composed from source
                    Control.Fill = new ImageBrush { ImageSource = bitmapImage, Stretch = Stretch.UniformToFill };
            }
            catch
            {   //TODO: Use some global logging mechanism here. Application Insights or something.
                Debug.WriteLine("Couldn't create ImageCircle, using Image defaults.");
            }
        }
    }
}