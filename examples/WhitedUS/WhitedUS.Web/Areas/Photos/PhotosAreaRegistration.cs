using System.Web.Mvc;

namespace WhitedUS.Web.Areas.Administration
{
    public class PhotosAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "Photos"; }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("Areas/Photos/Scripts/{*pathInfo}");
            context.Routes.IgnoreRoute("Areas/Photos/Services/{*pathInfo}");

            context.MapRoute(
                "Photos_Viewer",
                "View",
                new { action = "Viewer", controller = "Content" }
                , new[] { "WhitedUS.PhotoStore.Controllers", }
            );
            context.MapRoute(
                "Photos_default",
                "Photos/{*pathInfo}",
                new { action = "Access", controller = "Content" }
                , new[] { "WhitedUS.PhotoStore.Controllers", }
            );
            context.MapRoute(
                "Photos_EXIF",
                "EXIF/{*pathInfo}",
                new { action = "EXIF", controller = "Content" }
                , new[] { "WhitedUS.PhotoStore.Controllers", }
            );
            context.MapRoute(
                "Photos_Tagged",
                "Tagged/{*tag}",
                new { action = "Tag", controller = "Content" }
                , new[] { "WhitedUS.PhotoStore.Controllers", }
            );
        }
    }
}
