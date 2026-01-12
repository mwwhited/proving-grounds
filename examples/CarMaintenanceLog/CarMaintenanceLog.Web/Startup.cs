using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CarMaintenanceLog.Web.Startup))]
namespace CarMaintenanceLog.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
