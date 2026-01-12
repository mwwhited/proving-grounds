using System.Web.Mvc;

namespace WhitedUS.Web.Areas.Administration
{
    public class AdministrationAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get { return "Administration"; }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.IgnoreRoute("Areas/Administration/Scripts/{*pathInfo}");

            context.MapRoute(
                "Administration_default",
                "Administration/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
            context.MapRoute(
                "Administration_Grid",
                "Administration/Grid/{controller}/{action}/{page}",
                new { action = "Index", page = 1 }
            );
        }
    }
}
