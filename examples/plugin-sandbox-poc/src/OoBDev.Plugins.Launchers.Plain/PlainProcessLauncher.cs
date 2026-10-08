using System.Diagnostics;

namespace OoBDev.Plugins.Launchers.Plain;

/// <summary>
/// Starts the plugin as an ordinary child process with redirected stdio. <b>No sandbox.</b> This exists so the
/// host core can be proven before the OS launchers (phase 2), and must never be described as isolating anything.
/// </summary>
public sealed class PlainProcessLauncher : Host.IPluginLauncher
{
    public ValueTask<Host.IPluginProcess> LaunchAsync(Host.PluginSpec spec, CancellationToken ct)
    {
        ct.ThrowIfCancellationRequested();
        var info = new ProcessStartInfo(ResolveExecutable(spec))
        {
            WorkingDirectory = spec.WorkingDirectory,
            RedirectStandardInput = true,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false,
            CreateNoWindow = true,
        };
        foreach (var arg in spec.Command.Skip(1)) info.ArgumentList.Add(arg);

        var process = new Process { StartInfo = info, EnableRaisingEvents = true };
        var exited = new TaskCompletionSource<int>(TaskCreationOptions.RunContinuationsAsynchronously);
        process.Exited += (_, _) =>
        {
            try { exited.TrySetResult(process.ExitCode); } catch (InvalidOperationException) { exited.TrySetResult(-1); }
        };
        process.Start();
        if (process.HasExited) exited.TrySetResult(process.ExitCode);   // exited before the handler was attached
        return ValueTask.FromResult<Host.IPluginProcess>(new PlainProcess(process, exited.Task));
    }

    /// <summary>A command with a directory part (<c>out/echo-go</c>) is relative to the plugin folder; a bare name is looked up on PATH.</summary>
    static string ResolveExecutable(Host.PluginSpec spec)
    {
        var command = spec.Command[0];
        if (command.IndexOfAny(['/', '\\']) < 0) return command;
        var path = Path.GetFullPath(command, Path.GetFullPath(spec.WorkingDirectory));
        if (OperatingSystem.IsWindows() && !File.Exists(path) && File.Exists(path + ".exe")) path += ".exe";
        return path;
    }

    sealed class PlainProcess(Process process, Task<int> exited) : Host.IPluginProcess
    {
        public Stream Input => process.StandardInput.BaseStream;
        public Stream Output => process.StandardOutput.BaseStream;
        public Stream? Error => process.StandardError.BaseStream;
        public Task<int> Exited => exited;

        public void Kill()
        {
            try { process.Kill(entireProcessTree: true); }
            catch (Exception ex) when (ex is InvalidOperationException or System.ComponentModel.Win32Exception or NotSupportedException) { }
        }

        public ValueTask DisposeAsync()
        {
            Kill();
            process.Dispose();
            return ValueTask.CompletedTask;
        }
    }
}
