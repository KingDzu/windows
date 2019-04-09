param(
    [Parameter(Mandatory=$False)]
    [string]$QueryName,
    [string]$FSName
)

if ($QueryName -eq '') {
    
                        $output =  "{`"data`":["
                        $query = $colItems = gwmi win32_volume | select Name,FileSystem | Where FileSystem -eq "CSVFS"
                        $count = $query | Measure-Object
                        $count = $count.count
                        foreach ($object in $query) {
                                $Name = [string]$object.Name
       $Name = $Name
       $Name = $Name -replace "}\\","`+"
       $Name = $Name -replace "\\","/"

                                $FileSystem = [string]$object.FileSystem
                                if ($count -eq 1) {
                                        $output = $output + "{`"{#FSNAME}`":`"$Name`",`"{#FSTYPE}`":`"$FileSystem`"}"
                                } else {
                                        $output = $output + "{`"{#FSNAME}`":`"$Name`",`"{#FSTYPE}`":`"$FileSystem`"},"
                                }
                                $count--
                        }

                        $output = $output + "]}"
                        Write-Host $output

    }

else {
    $FSName = $FSName -replace "Volume-","\\\\?\\Volume{"
    $FSName = $FSName -replace "\+","}\\"
    $FSName = $FSName -replace "/","\\"
    switch ($QueryName)
        {
        ('Capacity') {$Results = gwmi win32_volume -Filter "name = '$FSName'" | select Capacity | Format-Table -HideTableHeaders -AutoSize}
        ('FreeSpace') {$Results = gwmi win32_volume -Filter "name = '$FSName'" | select FreeSpace | Format-Table -HideTableHeaders -AutoSize}
        default {$Results = "Incorrect Command Given"}
        }
    $Results = $Results | Out-String
    $Results = $Results.trim()
    Write-Host $Results

}