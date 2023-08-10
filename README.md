# Power Platform CLI - PowerShell
This is a PowerShell extension build using Crescendo to help power users run some pac commands quickly.

# Pre-requisites

Install the following modules

```powershell
Install-Module -Name Microsoft.PowerShell.TextUtility -AllowPrerelease -Scope CurrentUser
Install-Module -Name Microsoft.PowerShell.ConsoleGuiTools -Scope CurrentUser
```

Since this is a wrapper on top of Power Platform CLI, you'll also need to have pac in your machine. Please also run `pac auth create` once to create an auth profile for the Default Environment, so that you will have atleast one connection setup in your machine before you run the PowerShell commands.

# Installation

You can now install the PACPowerShell module from [PowerShell Gallery](https://www.powershellgallery.com/packages/PACPowerShell/) by running

```powershell
Install-Module -Name PACPowerShell -AllowPrerelease -Scope CurrentUser
```
# Available Commands

| # | Command | Description |
| :--- | :--- | :--- |
| 1 | Add-AuthProfiles | Creates Auth profiles for all the environments that you have access. Access is determined by output of `pac org list` command |
| 2 | Select-AuthProfile | Select a specific auth profile |
| 3 | Get-UnmanagedSolutions | Displays the list of Unmanaged solutions for the current auth profile |
| 4 | Get-ManagedSolutions | Displays the list of Managed solutions for the current auth profile |
| 5 | Export-Solutions | Exports the selected Unmanaged solutions to the current folder |
| 6 | Expand-Solutions | Exports the selected Unmanaged solutions and also unpacks it using `pac solution clone` |
| 7 | Get-Users | Displays users along with their role |
| 8 | Get-UsersInRole | Displays users who have a specific role. Use -Role argument to specific the role name e.g `Get-UsersInRole -Role "System Administrator"` |
| 9 | Deploy-ManagedSolution | Take unmanaged solution from source environment and deploys it as Managed to a target environment |

# Contributing

Install Crescendo using

```powershell
Install-Module -Name Microsoft.PowerShell.Crescendo -AllowPrerelease
```

You can add additional commands to [pac.crescendo.json](./pac.crescendo.json) and build the Crescendo module using

```powershell
Export-CrescendoModule -ConfigurationFile pac.crescendo.json -ModuleName PACPowerShell -Force; Import-Module ./PACPowerShell.psd1 -Force
```
