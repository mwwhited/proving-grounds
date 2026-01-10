using System;
using System.Linq;
using Microsoft.Extensions.Logging;

namespace OoBDev.MessageBroker.Cli
{
    internal class ConsoleLogger : ILogger
    {
        public IDisposable BeginScope<TState>(TState state)
        {
            return Enumerable.Empty<int>().GetEnumerator();
        }

        public bool IsEnabled(LogLevel logLevel)
        {
            return true;
        }

        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception exception, Func<TState, Exception, string> formatter)
        {
            Console.WriteLine($"{logLevel} {eventId}) {formatter?.Invoke(state, exception)}");
        }
    }
}