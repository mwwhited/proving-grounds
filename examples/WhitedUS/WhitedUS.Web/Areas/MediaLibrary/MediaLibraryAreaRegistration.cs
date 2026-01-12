using System.Web.Mvc;

namespace WhitedUS.Web.Areas.MediaLibrary
{
    public class MediaLibraryAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "MediaLibrary";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "MediaLibrary_default",
                "MediaLibrary/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                new [] { "WhitedUS.Web.Areas.MediaLibrary.Controllers", }
            );
        }
    }
}
