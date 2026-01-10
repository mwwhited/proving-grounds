You will need this nuget store ... 
https://dotnet.myget.org/F/dotnet-core/api/v3/index.json

-u http://0.0.0.0:5000

https://kosagi.com/w/index.php?title=NeTV_Main_Page
https://kosagi.com/w/index.php?title=NeTV_Support
https://www.kosagi.com/w/index.php?title=NeTV_web_services#GetUrl
http://10.0.88.1/bridge?cmd=seturl&value=http%3A%2F%2F10.0.88.4%3A5000%2FScoreMachine
https://benfrain.com/understanding-the-viewport-meta-tag-and-css-viewport/
http://10.0.88.4:5000/ScoreMachine#Clock=20:05
https://www.codeproject.com/Articles/1204852/ASP-NET-Core-SignalR-Core-alpha
https://github.com/sutajiokousagi/chumby-netvbrowser
https://www.codeproject.com/articles/633378/asp-net-signalr-basis-step-by-step-part
www.dsheiko.com/weblog/websockets-vs-sse-vs-long-polling


cd /d C:\TFS.OoBDev\Sandbox\OoBDev.ScoreMachine\OoBDev.ScoreMachine.Web.Core
dotnet run

http://10.0.88.1/html_test/

run these to configure
http://10.0.88.1/bridge?cmd=enablessh
http://10.0.88.1/bridge?cmd=keepalive&value=off
http://10.0.88.1/bridge?cmd=seturl&value=http%3A%2F%2F10.0.88.4%3A5001
http://10.0.88.1/bridge?cmd=seturl&value=http%3A%2F%2F10.0.88.4%3A5000%2FScoreMachine

NeTVBrowser SetUrl http://10.0.88.4:5000/ScoreMachine

do this at home

http://192.168.1.136/bridge?cmd=enablessh
http://192.168.1.136/bridge?cmd=keepalive&value=off
http://192.168.1.136/bridge?cmd=seturl&value=http%3A%2F%2F192.168.1.153%3A5000%2FScoreMachine

https://github.com/sshnet/SSH.NET/
/etc/init.d/chumby-netvbrowser stop
NeTVBrowser -qws -nomouse &
 NeTVBrowser Javascript "console.log('hello');"
 
http://10.0.88.1/bridge?cmd=necommand&value=NeTVBrowser+JavaScript+%22updateWith(%7BplayerRightName%3A%22matt%22%7D)%3B%22

replace lights with png circles <= not needed ... used webkit fallback
convert to server sent events!!!
https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events

find code to release renew ip address


integrate to fencing time 
add logging

http://10.0.88.4:5001/Score
http://10.0.88.4:5001/Manager

To monitor the console for NeTV 

	* connect to SSH (10.0.88.1 if over USB)
	* run these commands
		*  /etc/init.d/chumby-netvbrowser stop
		*  NeTVBrowser -qws -nomouse


Run these in a command window as admin to open firewall

	* netsh http add urlacl url=http://10.0.88.4:5001/ user=%USERDOMAIN%\%USERNAME%
	* netsh advfirewall firewall add rule name="Open for USB NeTV" dir=in action=allow  remoteip=10.0.88.1

netsh http delete urlacl url=http://10.0.88.4:5001/
netsh advfirewall firewall delete rule name="Open for USB NeTV"

netsh advfirewall set allprofiles state off
netsh advfirewall set allprofiles state on

https://support.microsoft.com/en-us/help/947709/how-to-use-the-netsh-advfirewall-firewall-context-instead-of-the-netsh

netsh advfirewall firewall add rule name="OoBDev.ScoreMachine.Manager" dir=in action=allow program="C:\TFS.OoBDev\Sandbox\OoBDev.ScoreMachine\OoBDev.ScoreMachine.Manager\bin\Debug\OoBDev.ScoreMachine.Manager.exe" enable=yes

netsh advfirewall firewall add rule name="Open Port 5001" dir=in action=allow protocol=TCP localport=5001 profile=domain
netsh advfirewall firewall add rule name="Open Port 5001" dir=in action=allow protocol=TCP localport=5001 profile=private

netsh http add urlacl url=http://*:5001/ user=%USERNAME%

netsh advfirewall firewall add rule name="Open Port 5002" dir=in action=allow protocol=TCP localport=5002 profile=domain
netsh advfirewall firewall add rule name="Open Port 5002" dir=in action=allow protocol=TCP localport=5002 profile=private