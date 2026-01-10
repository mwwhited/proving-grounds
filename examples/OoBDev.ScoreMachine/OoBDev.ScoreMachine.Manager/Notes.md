https://support.microsoft.com/en-us/help/947709/how-to-use-the-netsh-advfirewall-firewall-context-instead-of-the-netsh

netsh advfirewall firewall add rule name="OoBDev.ScoreMachine.Manager" dir=in action=allow program="C:\TFS.OoBDev\Sandbox\OoBDev.ScoreMachine\OoBDev.ScoreMachine.Manager\bin\Debug\OoBDev.ScoreMachine.Manager.exe" enable=yes

netsh advfirewall firewall add rule name="Open Port 5001" dir=in action=allow protocol=TCP localport=5001 profile=domain
netsh advfirewall firewall add rule name="Open Port 5001" dir=in action=allow protocol=TCP localport=5001 profile=private

netsh http add urlacl url=http://*:5001/ user=%USERNAME%