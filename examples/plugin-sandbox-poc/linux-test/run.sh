#!/bin/sh
# Copies the POC out of the bind mount (so Windows bin/obj are not reused), builds the compiled plugins, runs the checks.
set -e
mkdir /work && cd /src && tar --exclude=.vs --exclude=bin --exclude=obj --exclude=out --exclude=.git -cf - . | tar -xf - -C /work && cd /work
(cd plugins/echo-go && go build -o out/echo-go .) 2>&1|tail -3; (cd plugins/echo-java && mkdir -p out && javac -d out *.java) 2>&1|tail -3
python3 host-sim/run_tests.py 2>&1 | tail -2 || true
(cd plugins/echo-go && go build -o out/echo-go . ) 2>&1 | tail -3 || true
(cd plugins/echo-java && mkdir -p out && javac -d out *.java) 2>&1 | tail -3 || true
(cd plugins/echo-dotnet && dotnet publish -c Release -o out 2>&1 | tail -2) || true
cd src && dotnet test PluginSandbox.slnx --logger "console;verbosity=normal" --filter "FullyQualifiedName!~Windows" 2>&1 | tail -40
