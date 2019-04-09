### For zabbix_agentd.conf
UserParameter=hyperv.discover,powershell.exe -file "%path%\HyperV_Status.ps1"
UserParameter=hyperv.check[*],powershell.exe -file "%path%\HyperV_Status.ps1" $1 $2
UserParameter=windisk.discover,powershell.exe -NoProfile -ExecutionPolicy Bypass -file "%path%\CSVDrives_Status.ps1"
UserParameter=windisk.check[*],powershell.exe -NoProfile -ExecutionPolicy Bypass -file "%path%\CSVDrives_Status.ps1" $1 "$2"