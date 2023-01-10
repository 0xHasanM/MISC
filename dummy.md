 # Important artifacts
| Live | offline | Tool |
| ------------- | ------------- | ------------- |
| HKEY_LOCAL_MACHINE/SYSTEM | C:\Windows\System32\config\SYSTEM | Registry Explorer/regrip |
| HKEY_LOCAL_MACHINE/SOFTWARE | C:\Windows\System32\config\SOFTWARE | Registry Explorer/regrip |
| HKEY_USERS | C:\Windows\System32\config\SAM | Registry Explorer/regrip |
| HKEY_CURRENT_USER | C:\Users\<USER>\NTUSER.dat<br>C:\Users\<user>\Local Settings\Application Data\Microsoft\Windows\UsrClass.dat | Registry Explorer/regrip |
| Amcache.hve | C:\Windows\appcompat\Programs\Amcache.hve | RegistryExplorer/regrip | 
| Event viewer -> Windows Logs -> SECURITY | C:\Windows\winevt\Logs\Security.evtx | Event logs Explorer |
| Event viewer -> Windows Logs -> SYSTEM |  C:\Windows\winevt\Logs\SYSTEM.evtx | Event logs Explorer |
| Event viewer -> Windows Logs -> Application |  C:\Windows\winevt\Logs\Application.evtx | Event logs Explorer |
| Event viewer -> Applications & service logs -> Microsoft -> Windows -> TaskScheduler -> Operational | Microsoft-Windows-TaskScheduler%4Operational.evtx | Event Log Explorer
| Event viewer -> Applications & service logs -> Microsoft -> Windows -> TaskScheduler -> Operational | Microsoft-Windows-TaskScheduler%4Operational.evtx | Event Log Explorer
# System Information
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| Windows version and installation date |  <ul><li>SOFTWARE\Microsoft\Windows NT\CurrentVersion |  <ul><li>RegistryExplorer<li>regrip |
| Computer name |  <ul><li>SYSTEM\ControlSet001\Control\ComputerName\ComputerName |  <ul><li>RegistryExplorer<li>regrip  |
| Timezone |  <ul><li>SYSTEM\ControlSet001\Control\TimeZoneInformation |  <ul><li>RegistryExplorer<li>regrip  |
| Startup and shutdown time | <ul><li>SYSTEM\ControlSet001\Control\Windows</li><li>SYSTEM.evtx 1074 (shutdown type) & 6005/6006 (event logs start/stop)</li></ul>|  <ul><li>TurnedTimesView |
 # Network Information
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| Identify physical cards | <ul><li>SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards | <ul><li>RegistryExplorer<li>regrip
| Identify interface configuration | <ul><li>SYSTEM\ControlSet001\Services\Tcpip\Parameters\Interfaces | <ul><li>RegistryExplorer<li>regrip
| Connections History | <ul><li>SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged<li>SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles<li>Microsoft-Windows-WLAN-AutoConfig%4Operational.evtx | <ul><li>WifiHistoryView
| Network shares | <ul><li>SYSTEM\ControlSet001\Services\LanmanServer\Shares | <ul><li>Registry Explorer/regrip |
# Users Information
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| Username, creation date ,login date, SID | <ul><li>SAM | <ul><li>RegistryExplorer<li>regrip |
| Login, logout, deletion, creation | <ul><li>Security.evtx<ul><li>4624 -> Successful logon event<li>4625 -> failed logon event<li>4634 -> Session terminated<li>4647 -> User initiated logoff<li>4672 -> Special privilege logon<li>4648 -> User run program as another user (Runas administrator)<li>4720/4726 -> Account creation/deletion | <ul><li>EventLog Explorer |
# File activities - what happened?
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| File name, path, timestamps, actions (i.e rename) | <ul><li>$MFT, $LogFile, $UsnJrnl:$J | <ul><li>NTFS Log Tracker
| Information about deleted files | <ul><li>$I30 | <ul><li>INDXRipper
# File activities - Who did it?
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| Failed/Succesful object access | <ul><li>Securit.evtx<ul><li>4656 -> User tried to access an object<li>4660 -> object was deleted<li>4663 -> User accessed the object successfuly<li>4658 -> the user closed the opened object (file) | <ul><li>EventLog Explorer |
| Recently used files/folders | <ul><li>NTUSER.dat<ul><li>Software\Microsoft\Office\15.0\<Office application>\File MRU<li>Software\Microsoft\Office\15.0\<Office application>\Place MRU<li>Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU\*<li>Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs<li>Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU<li>Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths | <ul><li>RegistryExplorer<li>regrip |
| Accessed folders | <ul><li>ShellBags<ul><li>NTUSER.dat<li>USRCLASS.dat | <ul><li>Shellbags Explorer
| Accessed files, its path, metadata, timestamps, drive letter | <ul><li>LNK files<ul><li>C:\Users\<User>\Appdata\Roaming\Microsoft\Windows\Recent<li>C:\Users\<User>\Desktop<li>C:\Users\<User>\AppData\Roaming\Microsoft\Office\Recent\ | <ul><li>LECmd |
| Frequently accessed files | <ul><li>JumpLists<ul><li>C:\Users\<User>\AppData\Roaming\Microsoft\ Windows\Recent\AutomaticDestinations<li>C:\Users\<User>\AppData\Roaming\Microsoft\ Windows\Recent\CustomDestinations | <ul><li>JumpLists Explorer |
# Connected devices
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| Vendor ID, Product ID, Serial Number, Device name | <ul><li>SYSTEM\ControlSet001\Enum\USB | <ul><li>RegistryExplorer<li>regrip |
| Serial Number, First connection time, last connection time, last removal time | <ul><li>SYSTEM\ControlSet001\USBSTOR | <ul><li>RegistryExplorer<li>regrip |
| USB Label | <ul><li>SYSTEM\ControlSet001\Enum\SWD\WPDBUSENUM | <ul><li>RegistryExplorer<li>regrip |
| GUID, TYPE, serial number | <ul><li>SYSTEM\ControlSet001\Control\DeviceClasses | <ul><li>RegistryExplorer<li>Regrip
| VolumeGUID, Volume letter, serial number | <ul><li>SYSTEM\MountedDevices<li>SOFTWARE\Microsoft\Windows Portable Devices\Devices<li>SOFTWARE\Microsoft\Windows Search\VolumeInfoCache | <ul><li>RegistryExplorer<li>regrip |
| Serial number, first connection time | <ul><li>setupapi.dev.log | <ul><li>notepad++ |
| Serial number, connections times, drive letter | <ul><li>SYSTEM.evtx<ul><li>20001 -> a new device is installed</ul><li>Security.evtx<ul><li>6416 -> new externel device recognized</ul><li>Microsoft-Windows-Ntfs%4Operational.evtx | <ul><li>EventLog Explorer |
| Automation | <ul><li>Registry<li>EventLogs<li>setupapi.dev.log | <ul><li>USBDeviceForensics<li>USBDetective |
# Execution activites
| What  | Where | Tool  |
| ------------- | ------------- | ------------- |
| Windows Services executable, date added | <ul><li>SYSTEM\CurrentControlSet\Services | <ul><li>RegistryExplorer<li>regrip |
| Service installation time, Service crashed, stop/start service event | <ul><li>Security.evtx<ul><li>4697 -> service gets installed</ul><li>SYSTEM.evtx<ul><li>7034 -> Service crashed<li>7035 -> start/stop requests<li>7036 -> service stoppped/started</ul> | <ul><li>Eventlog Explorer |
| Autorun applications | <ul><li>SOFTWARE\Microsoft\Windows\CurrentVersion\Run<li>SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce<li>SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run<li>SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce<li>NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Run<li>NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\RunOnce | <ul><li>RegistryExplorer<li>regrip |
| Frequently run programs, last time, number of execution | <ul><li>UserAssist<ul><li>NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist | <ul><li>UserAssist by didier steven |
| Run of older applications on newer system | <ul><li>SYSTEM\CurrentControlSet\Control\SessionManager\AppCompatCache\AppCompatCache | <ul><li>ShimCache parser |
| files path, md5 & sha1 hash | <ul><li>Amcache.hve | <ul><li>Amcache parser |
| Background applications | <ul><li>BAM & DAM<ul><li>SYSTEM\ControlSet001\Services\bam\State\UserSettings | <ul><li>RegistryExplorer<li>regrip |
| Filename, size, run count, each run timestamp, path | <ul><li>Prefetch<li>C:\Windows\Prefetch | <ul><li>WinPrefetchView |
| Program network usage, memory usage | <ul><li>SRUM<li>C:\Windows\System32\sru\SRUDB.dat | <ul><li>SrumECmd |
| Scheduled task | <ul><li>C:\Windows\Tasks<li>Software\Microsoft\Windows NT\CurrentVersion\Schedule\Taskcache\Tasks<li>Software\Microsoft\Windows NT\CurrentVersion\Schedule\Taskcache\Tree<li>Microsoft-Windows-TaskScheduler%4Operational.evtx | <ul><li>Task Scheduler Viewer |
# Memory analysis
| What  | plugin  |
| ------------- | ------------- |
| List processes | windows.pslist |
| Scan image for hidden processes | windows.psxview |
| List network connections | windows.netscan |
| List files loaded in memory | windows.filescan |
| Look for malicious codes in memory | windows.malfind |
# Wireshark filters cheatsheet
| What  | filter  |
| ------------- | ------------- |
| Source IP | ip.src == "127.0.0.1" |
| Destination IP | ip.dst == "127.0.0.1" |
| Protocol | http - ftp - dns - etc. |
| Source port | tcp.srcport == "80" - udp.srcport == "80" |
| Destination port | tcp.dstport == "80" - udp.dstport == "80" |
