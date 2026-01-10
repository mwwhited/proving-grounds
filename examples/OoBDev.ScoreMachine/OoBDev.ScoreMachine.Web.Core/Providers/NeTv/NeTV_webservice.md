= HTTP API =
The NeTV HTTP API provides a mechanism to interact with NeTV through web interface on port 80.<br>
The API can be called from a standard web browser, which will also display any results.<br>
This method is probably the easiest way to experiment with the API commands.
<br>
<br>
The simplest command to try out is
 http://localhost/bridge?cmd=Hello (from within NeTV)
 http://xxx.xxx.xxx.xxx/bridge?cmd=Hello (from other device. Replace xxx by the IP address of NeTV)
This will give some basic status and ID information about the device.
<br>
<br>
<span style="color:#A0A0A0">
More complex commands can be constructed as a POST Request as follow.<br/>
- POST to: http://localhost/bridge or http://xxx.xxx.xxx.xxx/bridge<br/>
- '''Content-Type''' must be set to application/x-www-form-urlencoded<br/>
- variable '''cmd''' : command name, case insensitive<br/>
- variable '''data''' : optional variable to submit arguments with the command, formatted as a XML string<br/>
<br>
Example: to send a remote control key command (single parameter)<br/>
- cmd=RemoteControl<br/>
- data=<value>right</value><br/>
Example: to send a TickerEvent command (multiple parameters)<br/>
- cmd=TickerEvent<br/>
- data=<message>abcdefghifk</message><title>blahblah</title><image>full url to an image<image><br/>
</span>
<span style="color:#FF0000">[The above format is deprecated]</span><br/>
<br/>
More complex commands can be constructed as a GET/POST request.<br/>
Variables be GET/POST directly as normal HTML form variables (must be URI-encoded).<br/>
Example: to send a remote control key command (single parameter)
* cmd=RemoteControl
* value=right
Example: to send a TickerEvent command (multiple parameters)
* cmd=TickerEvent
* message=abcdefghifk
* title=blahblah
* image=full url to an image
<br/>
= Generic return format =
The return format is a XML string in the following format
 <xml>
    <status>.....</status>
    <cmd>........</cmd>
    <data>.......</data>
 </xml>

* <b>status:</b>
** 0 - Unimplemented command
** 1 - Success
** 2 - General error
* <b>cmd:</b> is echo of the command name
* <b>data:</b> is the return data of the command, it is designed to be an array of XML elements. For single value response, this is always "<value>...</value>"

= NeTVServer =
These webservices are provided by NeTVServer process, which is a custom built webserver, located in '''/usr/bin/NeTVServer'''<br/>
It hosts:
* HTTP server on port 80, document root is located in /usr/share/netvserver/docroot
* TCP server on port 8081, accepting command & response in XML format
* UDP server on port 8082, accepting command & response in XML format
* Flash security policy server on port 843, simply allowing all cross-domain access to the device. See this [url=http://www.adobe.com/devnet/flashplayer/articles/socket_policy_files.html article].
There is a helper script to start/stop/restart this process
 /etc/init.d chumby-netvserver start
 /etc/init.d chumby-netvserver stop
 /etc/init.d chumby-netvserver restart
NeTVServer is a console application implemented with C++, Qt libraries and shell scripts.<br/>
Only 1 instance of NeTVServer is allowed to run at once. The 2nd instance starts up and return immediately.

= Cookies =
A simple demo of using cookies is available at http://10.0.88.1/session <br/>
This feature has not been fully tested. More documentation to be made available.<br/>
Alternatively, please use GetParam & SetParam commands to save non-volatile (persistent) data.

= Execute custom scripts =
NeTVServer has a mechanism to mimic behaviour of cgi-bin script execution.<br/>
This allows you to create custom shell scripts & have them executed from a normal HTTP GET/POST request.<br/>
There is no restrictions on which shell commands can/cannot be executed since root access is wide open.<br/>
Here are the steps to create a custom shell script & pass parameters to it:
* Mount read-write, create a script file, make it executable
 mount -o remount,rw /
 cd /usr/share/netvserver/docroot/scripts
 touch myscript.sh
 chmod +x myscript.sh
* Make your script do something useful. Example:
 #!/bin/bash
 uname -a
 chumby_version -f
 echo "\$1 = $1"
 echo "\$2 = $2"
 echo "\$3 = $3"
 echo "num = $#"
 # you can really kill yourself too
 #killall NeTVServer
 #reboot
* Execute it from HTTP interface http://10.0.88.1/scripts/myscript.sh?param1=aaaaaa&param2=bbbbbb&param3=ccccc<br/>
Gives you this response:
 Linux localhost.localdomain 2.6.28 #1 Mon Oct 10 17:17:41 SGT 2011 armv5tejl GNU/Linux
 19
 $1 = ccccc
 $2 = bbbbbb
 $3 = aaaaaa
 num = 3
'''Note:'''<br/>
Notice the reversed order of the parameters.<br/>
Since shell script doesn't use key=value pair like POST/GET, the name of the parameters (param1,2,3) don't really matter.<br/>
You can have it anything you like, eg. This has the same meaning: blah1=aaaaaa&blah2=bbbbbb&blah3=ccccc<br/>
<br/>
However, the lexicon order of the names are used when passed to the shell script.<br/>
So, the following will give you the opposite order: http://10.0.88.1/scripts/myscript.sh?zzz=aaaaaa&yyy=bbbbbb&xxx=ccccc<br/>
 $1 = aaaaaa
 $2 = bbbbbb
 $3 = ccccc

= TCP & UDP interfaces =
NeTVServer's TCP & UDP interfaces provide mechanisms to interact with NeTV through socket interface.<br/>
UDP interface is generally faster than HTTP & TCP and is more suitable for real-time commands like page scrolling and button events.<br/>
UDP broadcast messages are currently used by Android & iOS app for device discovery when NeTV's IP address is not known or when there are multiple NeTV devices in the same network.<br/>
TCP interface are currently used to exchange data between NeTVServer & NeTVBrowser<br/>
<br/>
For UDP messages, the client can choose to use either broadcast or unicast target IP address.<br/>
However, the reply from NeTV is always unicast back to the originating address.<br>
* TCP socket on port 8081
* UDP socket on port 8082
All commands & parameters are identical to HTTP API, except they have to be wrapped in XML format.<br/>
<br/>
Example messages to be transmitted to NeTV over UDP/TCP: <br/>
'''No parameter'''
 <xml>
    <cmd>Hello</cmd>
 </xml>
'''One parameter'''
 <xml>
    <cmd>RemoteControl</cmd>
    <data>
       <value>right</value>
    </data>
 </xml>
'''Multiple parameters'''
 <xml>
    <cmd>Hello</cmd>
    <data>
       <type>android</type>
       <version>0.5.6</version>
    </data>
 </xml>

 <xml>
    <cmd>SetParam</cmd>
    <data>
       <myKey1>myValue1</myKey1>
       <myKey2>myValue2</myKey2>
    </data>
 </xml>

= Command demos =
A demo HTML page is available at http://10.0.88.1/html_test/ (replace with NeTV's IP address). <br/>
Some commands exist in the demo page are under development and not documented in this wiki page. <br/>
It is not recommended to use them.<br/>

= Commands list =
Command names are case-insensitive.<br/>
Parameters are case-sensitive.

== <span style="color:#6598EB">Hello</span> ==
Returns some basic information about the device.<br/>
'''Parameters:'''<br/>
* (optionals) '''''type''''' = netvbrowser/android/iphone/ipad/ipod/desktop<br/>
* (optionals) '''''version''''' = some version number<br/>
These parameters are currently used by NeTVServer & NeTVBrowser to identify each other.<br/>
This is designed such that each client may function as an extension to NeTVServer.<br/>
In this case, NeTVBrowser provides UI/HTML/JavaScript extension.<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=hello <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>HELLO</cmd>
    <status>1</status>
    <data>
       <guid>A620123B-1F0E-B7CB-0E11-921ADB7BE22A</guid>
       <dcid>...a long string of 1024 bytes...</dcid>
       <hwver>...hardware version number...</hwver>
       <fwver>...firmware version number...</fwver>
       <internet>true/false/connecting</internet>
       <mac>48:5D:60:A3:AC:FF</mac>
       <ip>xxx.xxx.xxx.xxx</ip>
       <network>...a long XML string from network_status.sh...</network>
    </data>
 </xml>
''guid'' - a unique ID for each device. This is generated the very first time NeTV powers up<br/>
''hwver'' - hardware version<br/>
''fwver'' - firmware version, changed (increases) after every software update<br/>
''internet'' - true: connected to Internet; connection: trying to associate with WiFi network; false: cannot associate with WiFi network<br/>
''mac'' - MAC address of the WiFi interface<br/>
''ip'' - IP address of WiFi interface. When NeTV is in Access Point mode, the IP is always 192.168.100.1<br/>
''network'' - raw network status from shell command 'network_status.sh' providing some useful network parameters like dns, netmask, gateway, network configuration<br/>

== <span style="color:#6598EB">WifiScan</span> ==
Returns a list of WiFi network found by NeTV.<br/>
'''Parameters:'''<br/>
(no parameters)<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=wifiscan <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>WIFISCAN</cmd>
    <status>1</status>
    <data>
       <wifi><ssid>chumby_test_ap_1</ssid><qty>54/70</qty><lvl>-56</lvl><ch>3</ch><mode>Master</mode><encryption>NONE</encryption><auth>OPEN</auth></wifi>
       <wifi><ssid>bec</ssid><qty>28/70</qty><lvl>-82</lvl><ch>6</ch><mode>Master</mode><encryption>WEP</encryption><auth>WEPAUTO</auth></wifi>
       <wifi><ssid>ChumbyWPA</ssid><qty>50/70</qty><lvl>-60</lvl><ch>1</ch><mode>Master</mode><encryption>AES</encryption><auth>WPA2PSK</auth></wifi>
    </data>
 </xml>

== <span style="color:#6598EB">SetChromaKey</span> ==
Enable/disable chroma color filtering on FPGA.<br/>
When enabled, any pixel with color rgb=240,0,240 or #F000F0 will be see-through (showing video feed behind)<br/>
When disable, the screen will be mostly filled with the chroma color (pink).<br/>
'''Parameters:'''<br/>
* '''''value''''' = on/off (pick one)<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=setchromakey&value=off <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>SETCHROMAKEY</cmd>
    <status>1</status>
    <data>
       <value>some raw output from shell command</value>
    </data>
 </xml>

== <span style="color:#6598EB">EnableSSH</span> ==
Enable/disable SSH daemon.<br/>
If NeTV is powered by a USB port of a computer, SSH will be enabled automatically.
Output value can be optionally XML-escaped.<br/>
'''Parameters:'''<br/>
* (optional) '''''value''''' = start-chumby/stop/reload/force-reload/restart (pick one)<br/>
* (optional) '''''xmlescape''''' = true/false<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=enablessh <br/>
http://10.0.88.1/bridge?cmd=enablessh&value=stop <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>ENABLESSH</cmd>
    <status>1</status>
    <data>
       <value>some raw output from shell command</value>
    </data>
 </xml>

== <span style="color:#6598EB">RemoteControl</span> ==
Simulates an infra-red remote control button event.<br/>
'''Parameters:'''<br/>
* '''''value''''' = cpanel/widget/up/down/left/right/center (pick one)<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=remotecontrol&value=left <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>REMOTECONTROL</cmd>
    <status>1</status>
    <data>
       <value>echo of the actual button name received</value>
    </data>
 </xml>

== <span style="color:#6598EB">Key</span> ==
Simulates a single keyboard event on NeTVBrowser (and other connected TCP clients).<br/>
'''Parameters:'''<br/>
* '''''value''''' = cpanel/widget/up/down/left/right/center/[a-z]/[0-9]/home/end/delete/pgup/pgdown/punctuations/... (pick one)<br/>
Full list is available [http://git.chumby.com.sg/gitweb/?p=chumby-sg/chumby-netvbrowser.git;a=blob;f=mainwindow_common.cpp here]<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=key&value=left <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>KEY</cmd>
    <status>1</status>
    <data>
       <value>echo of the actual key name received</value>
    </data>
 </xml>

== <span style="color:#6598EB">FileExists</span> ==
Checks whether a file exists in local filesystem.<br/>
'''Parameters:'''<br/>
* '''''value''''' = full path to a local file<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=fileexist&value=%2Fpsp%2Fnetwork_config (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>FILEEXISTS</cmd>
    <status>1</status>
    <data>
       <value>true/false</value>
    </data>
 </xml>

== <span style="color:#6598EB">GetFileContents</span> ==
Returns the content of a file in local filesystem.<br/>
Output value can be optionally XML-escaped.<br/>
'''Parameters:'''<br/>
* (required) '''''value''''' = full path to a local file<br/>
* (optional) '''''xmlescape''''' = true/false<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=getfilecontents&value=%2Fpsp%2Fnetwork_config (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>GETFILECONTENTS</cmd>
    <status>1</status>
    <data>
       <value>......raw file content......</value>
    </data>
 </xml>
 or
 <xml>
    <cmd>GETFILECONTENTS</cmd>
    <status>2</status>
    <data>
       <value>file not found</value>
    </data>
 </xml>
'''Note:'''<br/>
The returned data is neither XML-escaped or URI-encoded by default.<br/>

== <span style="color:#6598EB">GetFileSize</span> ==
Returns the size of a file in local filesystem.<br/>
'''Parameters:'''<br/>
* '''''value''''' = full path to a local file<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=getfilesize&value=%2Fpsp%2Fnetwork_config (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>GETFILESIZE</cmd>
    <status>1</status>
    <data>
       <value>size of the file in bytes</value>
    </data>
 </xml>
 or
 <xml>
    <cmd>GETFILESIZE</cmd>
    <status>2</status>
    <data>
       <value>file not found</value>
    </data>
 </xml>

== <span style="color:#6598EB">UnlinkFile</span> ==
Delete a file in NeTV's filesystem.<br/>
NeTV's filesystem is mounted as read-only by default except for some special locations. This command will return error condition if it is trying to delete a read-only location.<br/>
If there is a need to delete file in such locations, please first use NeCommand (with value = "mount -o remount,rw /") to mount the filesystem as read-write.<br/>
This command will return success (true) if the file does not exist.<br/>
'''Parameters:'''<br/>
* '''''value''''' = full path to a local file<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=unlinkfile&value=%2Fpsp%2Fsome_file.txt (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>UNLINKFILE</cmd>
    <status>1</status>
    <data>
       <path>echo of the input path</path>
       <value>true</value>
    </data>
 </xml>
 or 
 <xml>
    <cmd>UNLINKFILE</cmd>
    <status>2</status>
    <data>
       <path>echo of the input path</path>
       <value>false</value>
    </data>
 </xml>

== <span style="color:#6598EB">UploadFile</span> ==
Use HTML form to POST a file to any where in NeTV's filesystem.<br/>
Only traditional HTML <form> is supported. jQuery .post() is not supported.<br/>
NeTV's filesystem is mounted as read-only by default except for some special locations.<br/>
'''/psp''' is recommended for storing files persistently (non-volatile).<br/>
'''/tmp''' is in fact located in RAM, hence will store volatile files. It is not recommended to upload too big files here due to limited RAM.<br/>
If there is a need to upload file to other locations, please first use NeCommand (with value = "mount -o remount,rw /") to mount the filesystem as read-write.<br/>
'''HTML form code:'''<br/>
 <form method="post" enctype="multipart/form-data">
     <input type="hidden" name="cmd" value="uploadfile">
     <input type="hidden" name="path" value="/tmp/abc.jpg">
     <input type="file" name="filedata">
     <input type="submit">
 </form>
A demo page is available at http://10.0.88.1/html_test/index.html<br/>
'''HTTP GET example:'''<br/>
(GET is not supported)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>UPLOADFILE</cmd>
    <status>1</status>
    <data>
       <path>echo of the input path</path>
       <filesize>size of the file in bytes</filesize>
    </data>
 </xml>
 or
 <xml>
    <cmd>UPLOADFILE</cmd>
    <status>2</status>
    <data>
       <path>echo of the input path</path>
       <message>some helpful error messages</message>
    </data>
 </xml>
'''Tricks:''' You can upload a file to /tmp, for eg. /tmp/abc.jpg, and access it via HTTP as <nowiki>http://10.0.88.1/tmp/netvserver/abc.jpg</nowiki>

== <span style="color:#6598EB">GetParam</span> ==
Gets the non-volatile value of a single parameter saved locally in filesystem.<br/>
The parameters are saved in '''/psp/parameters.ini''' using QSettings' default implementation.<br/>
'''Parameters:'''<br/>
* '''''value''''' = name of the parameter<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=getparam&value=ticker_speed <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>GETPARAM</cmd>
    <status>1</status>
    <data>
       <value>value of the parameter</value>
    </data>
 </xml>

== <span style="color:#6598EB">GetParams</span> ==
Gets the non-volatile value of multiple parameters saved locally in filesystem.<br/>
The parameters are saved in '''/psp/parameters.ini''' using QSettings' default implementation.<br/>
'''Parameters:'''<br/>
* '''''value''''' = name of the parameters, comma seperated<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=getparam&value=myparam1%3Bmydata%3Banotherone (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>GETPARAMS</cmd>
    <status>1</status>
    <data>
       <myparam1>value of the myparam1</myparam1>
       <mydata>value of the mydata</mydata>
       <anotherone>value of the anotherone</anotherone>
    </data>
 </xml>

== <span style="color:#6598EB">SetParam</span> ==
Set new value(s) for non-volatile parameter(s) saved locally in filesystem.<br/>
The parameters are saved in '''/psp/parameters.ini''' using Qt QSettings' default implementation.<br/>
'''Parameters:'''<br/>
* (required) '''''name_of_1st_param = value of 1st parameter<br/>
* (optional) '''''name_of_2nd_param = value of 2nd parameter<br/>
* (optional) '''''name_of_3rd_param = value of 3rd parameter<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=setparam&dataxml_ticker_speed=1&dataxml_ticker_ypos=123 <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>SETPARAM</cmd>
    <status>1</status>
    <data>
       <value>number of parameters received</value>
    </data>
 </xml>
'''Note:'''<br/>
There was a bug in firmware earlier than 20. Please prefix parameter names with 'dataxml_'<br/>
Firmware 20 and newer does not require this.<br/>

== <span style="color:#6598EB">TickerEvent</span> ==
Shows a ticker message crawling across the screen.<br/>
'''Parameters:'''<br/>
* (required) '''''message''''' = long content of message<br/>
* (optional) '''''title''''' = a short title<br/>
* (optional) '''''image''''' = full url to a small thumbnail image<br/>
* (optional) '''''type''''' = system/widget/sms<br/>
* (optional) '''''level''''' = low/high<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=tickerevent&message=you%20should%20see%20this%20thing%20crawling%20across%20the%20screen&title=Hello%20World (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>TICKEREVENT</cmd>
    <status>1</status>
    <data>
       <value>command forwarded to browser</value>
    </data>
 </xml>
 or
 <xml>
    <cmd>TICKEREVENT</cmd>
    <status>2</status>
    <data>
       <value>no browser is running</value>
    </data>
 </xml>

== <span style="color:#6598EB">GetUrl</span> ==
Download the content of a URL and return as a long text string.<br/>
This command was designed mainly to over come JavaScript's restriction when getting XML content from cross-domain web services.<br/>
Internally, NeTVServer is using shell's curl command to perform the download, hence no such restrictions.<br/>
Output value can be optionally XML-escaped.<br/>
'''Parameters:'''<br/>
* (required) '''''url''''' = full url to some web resource (URI encoded) <br/>
* (optional) '''''post''''' = POST data in format param1=value1&param2=value2 (before URI encoded) <br/>
* (optional) '''''xmlescape''''' = true/false<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=geturl&url=http%3A%2F%2Fwww.google.com.sg%2Fsearch&post=q%3Dabc (URI encoded, encode value of 'post' variable too) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>GETURL</cmd>
    <status>1</status>
    <data>
       <value>......a long string of returned data......</value>
    </data>
 </xml>
'''Note:'''<br/>
The returned data is neither XML-escaped or URI-encoded by default.<br/>

== <span style="color:#6598EB">SetUrl</span> ==
Points the NeTVBrowser (tab 0) at a specified URL.<br/>
'''Parameters:'''<br/>
* '''''value''''' = full url to a web resource <br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=seturl&value=http%3A%2F%2Fwww.abc.com (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>SETURL</cmd>
    <status>1</status>
    <data>
       <value>Command forwarded to NeTVBrowser</value>
    </data>
 </xml>
'''Note:''' There is a keep-alive timer in NeTVBrowser running at 1 minute interval to keep URL of tab 0 pointing at a local page (http://localhost/...)<br/>
See 'KeepAlive' command for more information.

== <span style="color:#6598EB">Multitab</span> ==
NeTVBrowser supports multi-tab browsing, much like modern web browsers.<br/>
The first tab (index 0) is reserved for NeTV's Control Panel. The other tabs (index 1 to 9) can be shown/hide/load with other contents without affecting the Control Panel.<br/>
'''Parameters:'''<br/>
* (required) '''''tab''''' = index of the tab (1 to 9)<br/>
* (required) '''''options''''' = load/show/hide/hideall/close/closeall/html <br/>
* (optional) '''''param''''' = [full url to load if options==load] or [raw html syntax if options==html] (URI encoded) <br/>
'''Hide vs Close:'''<br/>
Using 'hide' and 'hideall' option will leave the tab running in the background while showing other tabs.<br/>
Using 'close' and 'closeall' option will destroy the tab and free its memory. Note: tab 0 cannot be closed. <br/>
Parameter 'tab' is not used for 'hideall' & 'closeall' option.<br/>
'''Scrolling:'''<br/>
Scrolling is done by setting the top-left offset position of the page.<br/>
Usually x-axis is kept at 0 and y-axis (vertical) is changed as the TV screen is wide enough to accommodate the content horizontally.<br/>
The scrolling position can be set in pixel coordinate or normalized fraction (0.0 to 1.0) with respect to the content width/height.<br/>
It is recommended to use '''UDP''' to fire this command rapidly per scroll event on mobile device.<br/>
* '''''tab''''' = index of the tab (1 to 9)<br/>
* '''''options''''' = 'scroll' (pixel coordinate) or 'scrollf' (normalized fraction 0.0-1.0) <br/>
* '''''param''''' = 'xxx,yyy' (comma-separated x,y scrolling positions) <br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=multitab&tab=1&options=load&param=http%3A%2F%2Fwww.abc.com (URI encoded) <br/>
http://10.0.88.1/bridge?cmd=multitab&tab=1&options=scrollf&param=0.0%2C0.123 (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>MULTITAB</cmd>
    <status>1</status>
    <data>
       <value>command forwarded to browser</value>
    </data>
 </xml>
 or
 <xml>
    <cmd>MULTITAB</cmd>
    <status>2</status>
    <data>
       <value>browser not found</value>
    </data>
 </xml>

== <span style="color:#6598EB">KeepAlive</span> ==
Enable/disable keep-alive timer in NeTVBrowser<br/>
There is a keep-alive timer in NeTVBrowser running at 1 minute interval to keep URL of tab 0 pointing at a local page (http://localhost/...)<br/>
In other to have tab 0 run an external URL, there are 2 options:
* Disable keep-alive timer
* The page must contains JavaScript function "fCheckAlive();" that returns 'true'.
'''Parameters:'''<br/>
* '''''value''''' = on/off <br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=keepalive&value=off <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>KEEPALIVE</cmd>
    <status>1</status>
    <data>
       <value>Command forwarded to NeTVBrowser</value>
    </data>
 </xml>

== <span style="color:#6598EB">NeCommand</span> ==
Execute any shell command and return the output as a string.<br/>
Full path to the executable must be provided. Arguments are space-separated.<br/>
Output value can be optionally XML-escaped.<br/>
'''Parameters:'''<br/>
* (required) '''''value''''' = the shell command to execute<br/>
* (optional) '''''xmlescape''''' = true/false<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=necommand&value=%2Fbin%2Funame%20-a (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>NECOMMAND</cmd>
    <status>1</status>
    <data>
       <value>......output of the shell command......</value>
    </data>
 </xml>
 or
 <xml>
    <cmd>NECOMMAND</cmd>
    <status>1</status>
    <data>
       <value>no permission to execute</value>
    </data>
 </xml>
'''Note:'''<br/>
The returned data is neither XML-escaped or URI-encoded by default.<br/>

== <span style="color:#6598EB">GetDocroot</span> ==
Returns the current absolute path to docroot folder of control panel.<br/>
From firmware 22 onwards, the control panel UI is pulled from a git repo to /media/storage/docroot every time NeTVBrowser starts/restarts. NeTVServer will switch to this path if the git pull succeeded. Otherwise, it will fallback to /usr/share/netvserver/docroot as usual.<br/>
This will enable us to quickly fix any bugs in the Control Panel without having to perform big a firmware update.<br/>
'''Parameters:'''<br/>
(no parameters)<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=getdocroot <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>GETDOCROOT</cmd>
    <status>1</status>
    <data>
       <value>/media/storage/docroot</value>
    </data>
 </xml>
'''Note:'''<br/>
Although the Control Panel UI is now located in /media/storage/docroot, basic life support stuffs such as the Update UI, WiFi config UI, supporting shell scripts are still located in /usr/share/netvserver/docroot.

== <span style="color:#6598EB">SetDocroot</span> ==
<br/>
Full path to the new docroot folder.<br/>
The docroot folder must minimality contains an index.html as the starting point.<br/>
'''Parameters:'''<br/>
* '''''value''''' = absolute path to a local docroot folder.<br/>
'''HTTP GET example:'''<br/>
http://10.0.88.1/bridge?cmd=setdocroot&value=%2Fmedia%2Fstorage%2Fmydocroot (URI encoded) <br/>
(replace with NeTV's IP address)<br/>
'''Return:'''<br/>
 <xml>
    <cmd>SETDOCROOT</cmd>
    <status>1</status>
    <data>
       <value>......echo of the input path......</value>
    </data>
 </xml>
'''Note:'''<br/>
Although the Control Panel UI is now located in /media/storage/docroot, basic life support stuffs such as the Update UI, WiFi config UI, supporting shell scripts are still located in /usr/share/netvserver/docroot.
<br/>It is NOT necessary to copy over those files to the new docroot folder.
