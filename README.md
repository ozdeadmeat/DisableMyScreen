# DisableMyScreen
Simple script that allows you to enable or disable a specific monitor. Designed to allow me to turn one monitor off when i wanted to play VR with my Varjo Aero.

It requires MultiMonitorTool.exe that can be downloaded [here](https://www.nirsoft.net/utils/multi_monitor_tool.html)

I use this with my Stream Deck, Using a System (Open Application) and put this into the App/File. Using this method it is expected you have PowerShell 7+. Change the location of the file accordingly. Both the PowerShell script and the MultiMonitorTool.exe should be in the same location.

pwsh.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File G:\Games\DisableMyScreen.ps1 -SwitchMonitor
