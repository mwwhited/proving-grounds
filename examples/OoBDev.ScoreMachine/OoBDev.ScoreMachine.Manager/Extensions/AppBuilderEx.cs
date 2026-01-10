using Owin;
using System;
using System.Linq;

namespace OoBDev.ScoreMachine.Manager.Extensions
{
    public static class AppBuilderEx
    {
        public static IAppBuilder SetupThese(this IAppBuilder appBuilder, params Func<IAppBuilder, IAppBuilder>[] configs)
        {
            configs?.Aggregate(appBuilder, (app, config) => config(app));
            return appBuilder;
        }
    }
}
