using System;
using System.Diagnostics;
using System.Threading.Tasks;
using Mobile.Abstractions;
using Mobile.Services;
using Xamarin.Forms;

[assembly: Dependency(typeof(LogService))]
namespace Mobile.Services
{
    public class LogService : IAppLogger
    {
        public async Task CriticalLine(string line)
        {
            await Task.Run(() => 
            { 
                Debug.WriteLine($@"[CRITICAL] {line}");
            });
        }

        public async Task DetailLine(string line)
        {
            await Task.Run(() =>
            {
                Debug.WriteLine($@"[DETAIL] {line}");
            });
        }

        public async Task ErrorLine(string line)
        {
            await Task.Run(() =>
            {
                Debug.WriteLine($@"[ERROR] {line}");
            });
        }

        public async Task InfoLine(string line)
        {
            await Task.Run(() =>
            {
                Debug.WriteLine($@"[INFO] {line}");
            });
        }
    }
}
