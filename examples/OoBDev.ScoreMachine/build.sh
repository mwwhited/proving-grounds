## Build Script
cd OoBDev.ScoreMachine.Web.Core
dotnet build -v d OoBDev.ScoreMachine.Web.Core.csproj
cd ..

cd OoBDev.ScoreMachine.NetTv.Core 
dotnet build -v d OoBDev.ScoreMachine.NetTv.Core.csproj
cd ..

cd OoBDev.ScoreMachine.Emulator.Core 
dotnet build -v d OoBDev.ScoreMachine.Emulator.Core.csproj
cd ..