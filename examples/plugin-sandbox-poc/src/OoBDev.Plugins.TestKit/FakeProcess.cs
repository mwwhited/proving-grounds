using OoBDev.Plugins.Host;
using System.IO.Pipelines;

namespace OoBDev.Plugins.TestKit;

/// <summary>A fake OS process whose behaviour is a script running over in-memory pipes.</summary>
public sealed class FakeProcess : IPluginProcess
{
    private readonly Pipe _toPlugin = new();
    private readonly Pipe _fromPlugin = new();
    private readonly CancellationTokenSource _kill = new();
    private readonly TaskCompletionSource<int> _exited = new(TaskCreationOptions.RunContinuationsAsynchronously);
    private readonly Stream _input;
    private readonly Stream _output;

    public FakeProcess(PluginScript script)
    {
        _input = _toPlugin.Writer.AsStream();
        _output = _fromPlugin.Reader.AsStream();
        var channel = new FakeChannel(_toPlugin.Reader.AsStream(), _fromPlugin.Writer.AsStream(), _kill.Token);
        _ = Task.Run(async () =>
        {
            var code = 137;   // killed
            try { code = await script(channel); }
            catch (OperationCanceledException) { }
            catch (Exception) { code = 1; }
            finally
            {
                await _fromPlugin.Writer.CompleteAsync();
                await _toPlugin.Reader.CompleteAsync();
                _exited.TrySetResult(_kill.IsCancellationRequested ? 137 : code);
            }
        });
    }

    public bool WasKilled => _kill.IsCancellationRequested;
    public Stream Input => _input;
    public Stream Output => _output;
    public Stream? Error => null;
    public Task<int> Exited => _exited.Task;
    public void Kill() { try { _kill.Cancel(); } catch (ObjectDisposedException) { } }
    public ValueTask DisposeAsync() { Kill(); return ValueTask.CompletedTask; }
}
