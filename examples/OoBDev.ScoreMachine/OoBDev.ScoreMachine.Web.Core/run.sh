export SM_WEBHOST=
export SM_NETVHOST=
export SM_E810HOST=
export SM_BUSYLIGHT=

export SM_H4NPORT=/dev/$(dmesg | grep ttyUSB | grep pl2303 | grep -oE '[^ ]+$' | tail -n 1)
export SM_HDMIPORT=/dev/$(dmesg | grep ttyUSB | grep  ch341-uart | grep -oE '[^ ]+$' | tail -n 1)

cd /home/pi/tfs/oobdev/Sandbox/OoBDev.ScoreMachine/OoBDev.ScoreMachine.Web.Core
dotnet run -v d --no-build OoBDev.ScoreMachine.Web.Core.csproj
