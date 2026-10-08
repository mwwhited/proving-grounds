FROM mcr.microsoft.com/dotnet/sdk:10.0
RUN apt-get update && apt-get install -y --no-install-recommends python3 python-is-python3 golang-go default-jdk-headless nodejs bubblewrap && rm -rf /var/lib/apt/lists/*
WORKDIR /poc
