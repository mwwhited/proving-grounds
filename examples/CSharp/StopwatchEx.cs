using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace Originations.DataProviders.Diagnostics
{
    public static class StopwatchEx
    {
        private static Stopwatch _watch = Stopwatch.StartNew();
        private static Stopwatch _all = Stopwatch.StartNew();

        [Conditional("DEBUG")]
        public static void Poll([CallerMemberName] string caller = null)
        {
            Debug.WriteLine(string.Join(":", "Total", _all.ElapsedMilliseconds, "Since Last", _watch.ElapsedMilliseconds), string.Concat("Stopwatch:", caller));
            _watch.Restart();
        }
    }
}
