integrate to fencing time 
add logging

http://10.0.88.4:5001/
http://10.0.88.4:5001/Manager.html

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