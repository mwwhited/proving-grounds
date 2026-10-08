# User journeys

Each journey follows one actor from a goal to an outcome. "Today" says what works now (in the POC code folder, see [README.md](README.md)); "Planned" names the phase in [plan.md](plan.md). Code in the planned steps is **illustrative and uncompiled**: it shows the intended feel of the API, not a committed design.

## J1. A plugin author writes a first plugin (today)

**Goal:** Extend an application with a plugin in the author's favourite language, without learning the host.

1. Reads `PROFILE.md` (one page): framing, envelope, six rules.
2. Copies the closest example (`echo-python`, `echo-dotnet` or `ticker-node`) and changes the ID and handlers.
3. Runs it under the stand-in host and sends it requests from a Python prompt (`README.md`, "Run by hand").
4. Adds a target to `run_tests.py` and runs the checks.
5. Fixes what fails. Typical first failures: a stray `print` on stdout, a blocking read before the first heartbeat, a heartbeat answered from a different thread than the request loop.

**Success:** All checks pass, with no host knowledge beyond the profile.
**Friction to watch:** Interpreted languages need a bundled runtime in a real package (design §3, Tier 2). The examples use the system interpreter, which hides that cost.

## J2. An author hardens a plugin against a hostile host environment (today)

**Goal:** Be sure the plugin behaves when the host does unpleasant things.

1. Reads the chaos table in `README.md` to see what a host will do to a bad plugin: kill on a 2 MiB frame, kill on bad JSON, treat an unanswered heartbeat as a hang, ignore a self-assigned `source`.
2. Checks the plugin never does those things, including under load.
3. Tests the plugin's own tolerance: kill it mid-request and confirm it restarts cleanly because it holds no state the host does not own (design decision 9).

**Success:** The plugin is idempotent and restartable.

## J3. An app developer hosts a plugin (planned, phase 1)

**Goal:** Let customers extend a .NET application with plugins that cannot take the application down.

1. Adds the host package and points it at a folder of plugin packages.
2. Starts the manager; it picks the platform entry, launches each plugin and supervises it.
3. Calls a plugin and subscribes to its events:

```csharp
// Illustrative only. Names and shapes are not decided.
var host = PluginHost.Create(options => options.PluginDirectory = "plugins");
await host.StartAsync();

var sum = await host.Plugin("echo-dotnet").RequestAsync<AddResult>("add", new { a = 2, b = 40 });
host.Subscribe("demo.tick", (source, payload) => Console.WriteLine($"{source}: {payload}"));
```

4. A plugin crashes; the app sees an event, the plugin restarts after a backoff, and calls during the gap fail fast with "unavailable".
5. At shutdown the host stops every plugin and waits within a bounded grace period.

**Success:** The app code never handles a plugin process directly.
**Open:** The API shape; whether `Plugin("name")` returns a typed client or a generic one.

## J4. An operator installs a third-party plugin (design only, not in the POC)

**Goal:** Allow a plugin from another vendor without trusting it blindly.

1. Drops a signed package in; the host verifies hashes and the signature.
2. Reviews what the manifest *requests*: topics, files, endpoints, each with a reason, and a warning if the combination lets data leave the host.
3. Approves a subset. The approval is stored with the package hash and signer, separately from the package.
4. Later, a new version asks for one more permission; the host requires re-approval. Revoking a permission takes effect on open streams immediately.

**Where this lives:** Design §10-11, planning-shell use cases 2, 14, 15. The POC proves only the signature and hash step (phase 5).

## J5. A security reviewer decides whether to trust the isolation (planned, phase 2 and 4)

**Goal:** See evidence, not claims.

1. Reads the claims in design §4 and the "Claims to verify" list in §18.
2. Runs the escape suite on a target OS. Each escape plugin tries one thing: open a socket, spawn a child, read a file outside its folder, fork-bomb, allocate until memory runs out, keep running after the host dies.
3. Reads the result table: held, failed or unverified, per OS.
4. Reads the failure analysis for anything that did not hold.

**Success:** A pass/fail table per OS that a reviewer can re-run, not prose.
**Fails if:** A single escape succeeds on a platform the project claims to support.

## J6. The host dies (planned, phase 2)

**Goal:** Bound plugins never outlive their host.

1. The reviewer starts the host with several Bound plugins.
2. Kills the host abruptly (Task Manager, `kill -9`), then again from inside a parent job object.
3. Checks that every plugin process is gone within a bounded time.

**Success:** Zero survivors in both cases. Detached plugins (phase 6) are the one deliberate exception and reattach on restart.

## J7. A maintainer verifies an unproven design claim (planned, phases 2-4)

**Goal:** Turn a "to verify" item in §18 into a recorded fact.

1. Picks a claim, for example "AppContainer with an inherited pipe handle can still use stdio".
2. Writes the smallest test that would disprove it.
3. Runs it on the target OS and records the result in the POC's findings file, then back-ports it to the planning shell's decision log.

**Success:** The claim is marked held, failed or unverified, with the evidence. A failed claim becomes a design change, not a footnote.

## J8. A maintainer promotes proven code into dotex (planned, phase 6)

**Goal:** Move reusable parts to the published framework without a rewrite.

1. Confirms the protocol, supervisor and launcher projects each build and test without referencing the POC.
2. Adds the dotex layering, README and coverage requirements.
3. Moves the projects, renames the namespaces, publishes the packages.

**Success:** The POC keeps working against the dotex packages with no changes to the plugins.
