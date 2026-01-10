using Microsoft.Extensions.Logging;

namespace OoBDev.MessageBroker.Cli
{
    internal class ConsoleLoggerFactory : ILoggerFactory
    {
        public ILogger Logger { get; }

        public ConsoleLoggerFactory(ILogger consoleLogger)
        {
            this.Logger = consoleLogger;
        }

        public void AddProvider(ILoggerProvider provider)
        {
        }

        public ILogger CreateLogger(string categoryName)
        {
            return this.Logger;
        }

        public void Dispose()
        {
        }
    }
}