using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(OobDev.ImageTools.Web.Startup))]
namespace OobDev.ImageTools.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
