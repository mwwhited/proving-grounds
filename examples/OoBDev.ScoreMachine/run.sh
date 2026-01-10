cd $HOME/tfs/oobdev/Sandbox/OoBDev.ScoreMachine

cd OoBDev.ScoreMachine.Web.Core
dotnet run -v d --no-build OoBDev.ScoreMachine.Web.Core.csproj -u=http://192.168.137.171:5000 -u=http://10.0.88.4:5000 &
cd ..

sleep 5
cd OoBDev.ScoreMachine.NetTv.Core 
dotnet run -v d --no-build OoBDev.ScoreMachine.NeTv.Core.csproj --netv=http://10.0.88.1 --hub=http://10.0.88.4:5000/
cd ..

fg dotnet
cd $HOME/tfs/oobdev/Sandbox/OoBDev.ScoreMachine

#cd OoBDev.ScoreMachine.Emultor.Core 
#dotnet run -v d --no-build OoBDev.ScoreMachine.Emultor.Core.csproj --hub=http://10.0.88.4:5000/ &
#cd ..