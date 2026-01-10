## Interfaces

sudo ifconfig -v usb0 10.0.88.4/24
sudo ifconfig -v eth0 192.168.137.171/24

## Run Script

cd $HOME/tfs/oobdev/Sandbox/OoBDev.ScoreMachine/OoBDev.ScoreMachine.Web.Core
dotnet run -v d --no-build OoBDev.ScoreMachine.Web.Core.csproj -u=http://192.168.137.171:5000 -u=http://10.0.88.4:5000

cd $HOME/tfs/oobdev/Sandbox/OoBDev.ScoreMachine/OoBDev.ScoreMachine.NetTv.Core 
dotnet run -v d --no-build OoBDev.ScoreMachine.NeTv.Core.csproj --netv=http://10.0.88.1 --hub=http://10.0.88.4:5000/

## Build Script
cd $HOME/tfs/oobdev/Sandbox/OoBDev.ScoreMachine/OoBDev.ScoreMachine.Web.Core
dotnet build -v d OoBDev.ScoreMachine.Web.Core.csproj

cd $HOME/tfs/oobdev/Sandbox/OoBDev.ScoreMachine/OoBDev.ScoreMachine.NetTv.Core 
dotnet build -v d OoBDev.ScoreMachine.NetTv.Core.csproj
