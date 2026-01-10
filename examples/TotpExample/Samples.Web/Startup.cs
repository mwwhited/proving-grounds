using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Samples.Web.Startup))]
namespace Samples.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
