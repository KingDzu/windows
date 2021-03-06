param(
	[Parameter(Mandatory=$False)]
	[string]$QueryName,
    [string]$VMName
)

if ($QueryName -eq '') {
    
    $colItems = Get-VM

    write-host "{"
    write-host " `"data`":["
    write-host

    foreach ($objItem in $colItems) {
        $line =  " { `"{#VMNAME}`":`"" + $objItem.Name + "`" , `"{#VMSTATE}`":`"" + $objItem.State + "`" },"
        write-host $line
    }

    write-host
    write-host " ]"
    write-host "}"
    write-host
}

else {

    switch ($QueryName)
        {
        ('State') {$Results = Get-VM -Name "$VMName"  | select State | Format-Table -HideTableHeaders -AutoSize}
        ('CPUUsage') {$Results = Get-VM -Name "$VMName" | select CPUUsage | Format-Table -HideTableHeaders -AutoSize}
        ('MemoryAssigned') {$Results = Get-VM -Name "$VMName" | select MemoryAssigned | Format-Table -HideTableHeaders -AutoSize}
        ('Uptime') {$Results = Get-VM -Name "$VMName" | select Uptime | Format-Table -HideTableHeaders -AutoSize}
        ('Status') {$Results = Get-VM -Name "$VMName" | select Status | Format-Table -HideTableHeaders -AutoSize}
	('Snapshots') {$Results = Get-VMSnapshot -VMName "$VMName" | select Name | Format-Table -HideTableHeaders -AutoSize}
        default {$Results = "Incorrect Command Given"}
        }
    $Results = $Results | Out-String
    $Results = $Results.trim()
    Write-Host $Results

}
