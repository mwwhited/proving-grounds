using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using OoBDev.ScoreMachine.Web.Core.Hubs;

namespace OoBDev.ScoreMachine.Web.Core
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(options =>
            {
                options.AddPolicy(ScoreMachineCors, b =>
                {
                    b.AllowAnyHeader()
                     .AllowAnyMethod()
                     .AllowAnyOrigin()
                     .DisallowCredentials()
                     ;
                });
            });
            services.AddMvc();
            services.AddSignalR();
        }

        readonly string ScoreMachineCors = "_ScoreMachineCors";

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            app.UseCors(ScoreMachineCors);
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseBrowserLink();
            }
            else
            {
                app.UseExceptionHandler("/Error");
            }
            app.UseStaticFiles();
            app.UseSignalR(routes =>
            {
                routes.MapHub<ScoreMachineHub>($"/{nameof(ScoreMachineHub)}");
            });
            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller}/{action=Index}/{id?}");
            });
        }
    }
}
