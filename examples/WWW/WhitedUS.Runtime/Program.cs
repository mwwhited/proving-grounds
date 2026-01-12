using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Runtime.Configuration;
using System.Threading;
using System.Collections.ObjectModel;

namespace WhitedUS.Runtime
{
    class Program
    {
        static void Main(string[] args)
        {
            Collection<Thread> threads = new Collection<Thread>();
            foreach (RuntimeModuleConfiguration runtimeModule in 
                                RuntimeConfiguration.Instance.RuntimeModules)
            {
                try
                {
                    var newThread = new Thread(new ThreadStart(delegate
                    {
                        runtimeModule.Invoke();
                    }));
                    newThread.Start();
                    newThread.Name = string.Format("RuntimeModule::{0}::{1}",
                                                   runtimeModule.ModuleType
                                                                .FullName,
                                                   runtimeModule.Key);
                    threads.Add(newThread);
                    Console.WriteLine(string.Format("\"{0}\" started",
                                                    runtimeModule.Key));
                }
                catch (Exception ex)
                {
                    Console.WriteLine(string.Format("Error: \"{0}\" - \"{1}\"",
                                                    runtimeModule.Key,
                                                    ex.Message));
                }
            }
        }
    }
}
