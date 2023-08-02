# Power Platform CLI - PowerShell
This is a PowerShell extension build using Crescendo to help power users run some pac commands quickly.

# Pre-requisites

Install the following modules

`Install-Module -Name Microsoft.PowerShell.TextUtility -AllowPrerelease -Scope CurrentUser`

`Install-Module -Name Microsoft.PowerShell.ConsoleGuiTools -Scope CurrentUser`

# Available Commands

| # | Command | Description |
| :--- | :--- | :--- |
| 1 | Add-AuthProfiles | Creates Auth profiles for all the environments that you have access. Access is determined by output of `pac org list` command |
| 2 | Select-AuthProfile | Select a specific auth profile |
| 3 | Get-UnmanagedSolutions | Displays the list of Unmanaged solutions for the current auth profile |
| 4 | Get-ManagedSolutions | Displays the list of Managed solutions for the current auth profile |
| 5 | Export-Solutions | Exports the selected Unmanaged solutions to the current folder |
| 6 | Expand-Solutions | Exports the selected Unmanaged solutions and also unpacks it using `pac solution clone` |
| 7 | Get-UsersInRole | Displays users along with their role |

# Contributing

You can add additional commands to [pac.json](./src/pac.json) and build the Crescendo module using

`Export-CrescendoModule -ConfigurationFile pac.json -ModuleName PsPAC -Force; Import-Module ./PsPAC.psd1 -Force`