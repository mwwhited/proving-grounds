#!/bin/sh
# Usage: linux-test/run-docker.sh   (from plugin-sandbox-poc/, on a machine with Docker)
# Unprivileged user namespaces are blocked by Docker's default seccomp profile, so the sandbox tests need it relaxed.
# That is a property of the test container, not of the launcher: say so whenever quoting results.
docker build -q -t plugin-poc-linux linux-test >/dev/null &&
docker run --rm --user 1000:1000 -e HOME=/tmp/home -e DOTNET_CLI_HOME=/tmp/home \
  --security-opt seccomp=unconfined --security-opt apparmor=unconfined \
  -v "$PWD:/src:ro" plugin-poc-linux sh /src/linux-test/run.sh
