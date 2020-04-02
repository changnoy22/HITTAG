using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(HITTAG.Startup))]
namespace HITTAG
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
