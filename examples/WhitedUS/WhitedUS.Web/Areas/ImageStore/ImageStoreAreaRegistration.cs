using System.Web.Mvc;

namespace WhitedUS.Web.Areas.MediaLibrary
{
    public class ImageStoreAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "ImageStore";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "ImageStore_default",
                "ImageStore/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                new[] { "WhitedUS.ImageStore.Controllers", }
            );
        }
    }
}
