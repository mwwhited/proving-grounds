using HidLibrary;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using UsbGps.Gps;

namespace UsbGps
{
    class Program
    {
        static void Main(string[] args)
        {
            var prog = new Program();
            prog.Execute().Wait();
            Console.WriteLine("fin!");
            Console.Read();
        }

        public async Task Execute()
        {
            var cancellationTokenSource = new CancellationTokenSource();
            try
            {
                foreach (var hid in HidDevices.Enumerate(0x1163, 0x0200))
                {
                    await this.MonitorGps(hid, s => Task.Run(() => Console.WriteLine("{1}:> {0}", s, Thread.CurrentThread.ManagedThreadId)), cancellationTokenSource);
                }
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex.Message);
                cancellationTokenSource.Cancel();
            }
        }

        private async Task MonitorGps(HidDevice hid, Func<string, Task> callback, CancellationTokenSource cancellationTokenSource)
        {
            hid.Removed += () =>
            {
                Console.WriteLine("Device Removed!");
                cancellationTokenSource.Cancel();
            };
            hid.OpenDevice();

            Console.WriteLine(hid.Description);
            Console.WriteLine(hid.DevicePath);

            using (var stream = new MemoryStream())
            using (var reader = new StreamReader(stream))
                await Task.WhenAll(
                    Task.Run(() => this.Source(hid, stream, cancellationTokenSource)),
                    Task.Run(() => this.Sink(reader, callback, cancellationTokenSource.Token)),
                    Task.Run(() => this.Pause(cancellationTokenSource))
                    );

            hid.CloseDevice();
        }

        private async Task Pause(CancellationTokenSource cancellationTokenSource)
        {
            Console.WriteLine("Press Enter to Exit");
            await Task.Run(() => Console.ReadLine(), cancellationTokenSource.Token);
            cancellationTokenSource.Cancel();
        }

        private object _sync = new object();

        private async Task Source(HidDevice hid, Stream stream, CancellationTokenSource cancellationTokenSource)
        {
            while (!cancellationTokenSource.Token.IsCancellationRequested)
            {
                var deviceData = await hid.ReadAsync();
                if (deviceData.Status != HidDeviceData.ReadStatus.Success)
                {
                    Console.WriteLine("Device Status: {0}", deviceData.Status);
                    cancellationTokenSource.Cancel();
                    break;
                }

               // Console.WriteLine("+++Start Write!");
                Monitor.Enter(this._sync);
                //Console.WriteLine("+++Write!");
                try
                {
                    await stream.WriteAsync(deviceData.Data, 0, deviceData.Data.Length, cancellationTokenSource.Token);
                    await stream.FlushAsync(cancellationTokenSource.Token);
                }
                finally
                {
                    Monitor.Exit(this._sync);
                }
                await Task.Yield();
            }
        }
        private async Task Sink(StreamReader reader, Func<string, Task> callback, CancellationToken cancellationToken)
        {
            string line;
            long lastPostion = 0;
            while (!cancellationToken.IsCancellationRequested)
            {
                //Console.WriteLine("+++Start Read!");
                Monitor.Enter(this._sync);
                //Console.WriteLine("+++Read");
                try
                {
                    if (reader.BaseStream.Position == lastPostion)
                    {
                        //await Task.Yield();
                        continue;
                    }
                    reader.BaseStream.Position = lastPostion;
                    //Console.WriteLine("p+: {0}", lastPostion);
                    line = await reader.ReadLineAsync();
                    lastPostion = reader.BaseStream.Position;
                    //Console.WriteLine("p-: {0}", lastPostion);
                }
                finally
                {
                    Monitor.Exit(this._sync);
                }
                await Task.Yield();

                if (!string.IsNullOrWhiteSpace(line))
                    await callback(line);
                //Thread.Sleep(100);
            }
        }
    }
}
