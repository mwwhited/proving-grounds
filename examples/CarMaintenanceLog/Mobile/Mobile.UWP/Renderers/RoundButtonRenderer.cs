using Mobile.Controls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml.Media;
using Xamarin.Forms;
using Xamarin.Forms.Platform.UWP;
using Windows.UI.Xaml.Shapes;
using Mobile.UWP.Renderers;

[assembly: ExportRenderer(typeof(RoundButton), typeof(RoundButtonRenderer))]
namespace Mobile.UWP.Renderers
{
    public class RoundButtonRenderer : ButtonRenderer
    {
        protected override void OnElementChanged(ElementChangedEventArgs<Button> e)
        {
            base.OnElementChanged(e);

            if (e.OldElement != null || this.Element == null)
                return;

            var roundButton = e.NewElement as RoundButton;
            if (roundButton == null)
                return;

            Control.BorderRadius = (int) roundButton.CornerRadius;
        }
    }
}
