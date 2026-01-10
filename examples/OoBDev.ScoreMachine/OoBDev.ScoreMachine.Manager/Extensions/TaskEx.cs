using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Manager.Extensions
{
    public static class TaskEx
    {
        public static IEnumerable<Task> StartAll(this CancellationTokenSource source, params Func<CancellationTokenSource, Task>[] configs)
        {
            foreach (var config in configs ?? Enumerable.Empty<Func<CancellationTokenSource, Task>>())
                yield return Task.Run(() => config(source), source.Token);
        }

        public static void WaitAll(this IEnumerable<Task> tasks)
        {
            if (tasks != null) try
                {
                    Task.WaitAll(tasks.ToArray());
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine(ex);
                }
        }
    }
}
