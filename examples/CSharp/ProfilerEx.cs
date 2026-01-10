using System;
using System.Diagnostics;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;

namespace Originations.DataProviders.Diagnostics
{
    public class ProfilerEx : IDisposable
    {
#if DEBUG
        private readonly Stopwatch _sw = Stopwatch.StartNew();
        private readonly string _path;
        private readonly string _caller;
        private readonly int _lineNumber;

        public ProfilerEx(
            [CallerFilePath] string path = "",
            [CallerMemberName] string caller = "",
            [CallerLineNumber] int lineNumber = 0
            )
        {
            _path = path;
            _caller = caller;
            _lineNumber = lineNumber;
        }
#endif

        public void Dispose()
        {
            //Note: this class only does work when compiled for Debug
#if DEBUG
            _sw.Stop();
            Debug.WriteLine(string.Join(":", _path, _caller, _lineNumber, _sw.ElapsedMilliseconds), "ProfilerEx");
#endif
        }

        public static T Wrap<T>(Func<T> worker
#if DEBUG
            , [CallerFilePath] string path = ""
            , [CallerMemberName] string caller = ""
            , [CallerLineNumber] int lineNumber = 0
#endif
            )
        {
#if DEBUG
            using (new ProfilerEx(path: path, caller: caller, lineNumber: lineNumber))
            {
                return worker();
            }
#else
                return worker();
#endif
        }
    }
}
