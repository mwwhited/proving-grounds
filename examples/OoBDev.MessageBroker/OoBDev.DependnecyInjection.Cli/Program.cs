using Microsoft.Extensions.DependencyInjection;
using System;

namespace OoBDev.DependnecyInjection.Cli
{
    class Program
    {
        static void Main(string[] args)
        {
            var collection = new ServiceCollection();
            //collection.AddSingleton<>
            //serviceC

            var provider = collection.BuildServiceProvider();
            //provider.


            Console.WriteLine("Hello World!");
        }
    }
}
