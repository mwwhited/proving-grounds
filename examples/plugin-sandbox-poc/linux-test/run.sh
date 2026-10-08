#!/bin/sh
# Copies the POC out of the bind mount (so Windows bin/obj are not reused), builds the compiled plugins, runs the checks.
set -e
mkdir /tmp/work && cd /src && tar --exclude=.vs --exclude=bin --exclude=obj --exclude=out --exclude=.git -cf - . | tar -xf - -C /tmp/work && cd /tmp/work
(cd plugins/echo-go && go build -o out/echo-go .) 2>&1|tail -3; (cd plugins/echo-java && mkdir -p out && javac -d out *.java) 2>&1|tail -3
python3 host-sim/run_tests.py 2>&1 | tail -2 || true
(cd plugins/echo-go && go build -o out/echo-go . ) 2>&1 | tail -3 || true
(cd plugins/echo-java && mkdir -p out && javac -d out *.java) 2>&1 | tail -3 || true
(cd plugins/echo-dotnet && dotnet publish -c Release -o out 2>&1 | tail -2) || true
cd src
dotnet build PluginSandbox.slnx -v q 2>&1 | grep -E " error " || true
dotnet test PluginSandbox.slnx --no-build --logger "console;verbosity=normal" 2>&1 | grep -vE "Passed OoBDev.Plugins.(Host|Protocol)" | tail -60
PLUGIN_LAUNCHER=bubblewrap dotnet test OoBDev.Plugins.Conformance --no-build --logger "console;verbosity=normal" 2>&1 | grep -E "Passed |Failed |Skipped |Total|Message|Error|exit" | head -40
