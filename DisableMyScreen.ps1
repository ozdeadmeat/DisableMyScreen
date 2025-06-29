Param (
    [switch]$SwitchMonitor
)
$MultiMonitorTool = "G:\Games\MultiMonitorTool.exe"
$MonitorCSV       = "G:\Games\monitors.csv"
$Disable_LeftTop = "3840, 0" #MUST BE EXACT, ANY DEViATION WILL NOT WORK (SPACES ETC)

function Update-CSV {
    $ARG = "/scomma $MonitorCSV"
    $s1 = Start-Process -FilePath $MultiMonitorTool -ArgumentList $ARG
    $s1 | Out-Null
    start-sleep -Milliseconds 500
    $rtn = Import-Csv $MonitorCSV
    return $rtn
}

function Show-MonitorID {
Update-CSV
$mCSV = Import-Csv $MonitorCSV
$mCSV | Select-Object Resolution, 'Left-Top', Active, Disconnected, Primary, Name, 'Monitor ID' | Format-Table
}
# function Get-MonitorID {
#     Update-CSV
#     $ListOfMonitors = Import-Csv $MonitorCSV
#     ForEach ($monitor in $ListOfMonitors) {
#         if($monitor.'Monitor ID' -eq $MonitorID) {
#             $str = $monitor.Name -replace "[^0-9]"
#             write-host"MonitorID = $str"
#             return $str
#         }
#     }
# }
function Get-MonitorID {
    $ListOfMonitors = Update-CSV
    $TargetMonitor = $ListOfMonitors | Where-Object { $_.'Left-Top' -eq $Disable_LeftTop }
    if ($null -ne $TargetMonitor) {
        $MonitorID = $TargetMonitor.'Monitor ID'
        #Write-Host "Matched Monitor: $($TargetMonitor.Name) | MonitorID = $($TargetMonitor.'Monitor ID')"
        return $MonitorID
    } else {
        Write-Host "No monitor found with Left-Top $Disable_LeftTop"
    }
}

function Switch-Monitor {
    $MonID = Get-MonitorID
    $ARG = "/switch $MonID"
    $s2 = Start-Process -FilePath $MultiMonitorTool -ArgumentList $ARG
    $s2 | Out-Null
}

if($SwitchMonitor) {
    Switch-Monitor
}