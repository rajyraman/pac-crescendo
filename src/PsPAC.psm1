# Module created by Microsoft.PowerShell.Crescendo
# Version: 1.1.0
# Schema: https://aka.ms/PowerShell/Crescendo/Schemas/2022-06#
# Generated at: 08/03/2023 21:42:48
class PowerShellCustomFunctionAttribute : System.Attribute { 
    [bool]$RequiresElevation
    [string]$Source
    PowerShellCustomFunctionAttribute() { $this.RequiresElevation = $false; $this.Source = "Microsoft.PowerShell.Crescendo" }
    PowerShellCustomFunctionAttribute([bool]$rElevation) {
        $this.RequiresElevation = $rElevation
        $this.Source = "Microsoft.PowerShell.Crescendo"
    }
}

# Queue for holding errors
$__CrescendoNativeErrorQueue = [System.Collections.Queue]::new()
# Returns available errors
# Assumes that we are being called from within a script cmdlet when EmitAsError is used.
function Pop-CrescendoNativeError {
param ([switch]$EmitAsError)
    while ($__CrescendoNativeErrorQueue.Count -gt 0) {
        if ($EmitAsError) {
            $msg = $__CrescendoNativeErrorQueue.Dequeue()
            $er = [System.Management.Automation.ErrorRecord]::new([system.invalidoperationexception]::new($msg), $PSCmdlet.Name, "InvalidOperation", $msg)
            $PSCmdlet.WriteError($er)
        }
        else {
            $__CrescendoNativeErrorQueue.Dequeue()
        }
    }
}
# this is purposefully a filter rather than a function for streaming errors
filter Push-CrescendoNativeError {
    if ($_ -is [System.Management.Automation.ErrorRecord]) {
        $__CrescendoNativeErrorQueue.Enqueue($_)
    }
    else {
        $_
    }
}

function Get-UnmanagedSolutions
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $False; Handler = { $args[0] | ConvertFrom-Json | where { $_.IsManaged -eq $false } | sort -Property FriendlyName | select SolutionUniqueName, FriendlyName, VersionNumber } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'solution'
    $__commandArgs += 'list'
    $__commandArgs += '--json'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Gets list of unmanaged solutions

#>
}


function Get-ManagedSolutions
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $input | ConvertFrom-Json | where { $_.IsManaged -eq $true } | sort -Property FriendlyName | select SolutionUniqueName, FriendlyName, VersionNumber } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'solution'
    $__commandArgs += 'list'
    $__commandArgs += '--json'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Gets list of managed solutions

#>
}


function Export-Solutions
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $selected = $input | ConvertFrom-Json | where { $_.IsManaged -eq $false } | sort -Property FriendlyName | select SolutionUniqueName, FriendlyName, VersionNumber | Out-ConsoleGridView; $selected | ForEach-Object { Write-Host "Exporting solution $($_.SolutionUniqueName).."; pac solution export -p . -n $_.SolutionUniqueName -ow } } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'solution'
    $__commandArgs += 'list'
    $__commandArgs += '--json'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Exports Unmanaged solution to disk

#>
}


function Expand-Solutions
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $selected = $input | ConvertFrom-Json | where { $_.IsManaged -eq $false } | sort -Property FriendlyName | select SolutionUniqueName, FriendlyName, VersionNumber | Out-ConsoleGridView; $selected | ForEach-Object { Write-Host "Cloning solution $($_.SolutionUniqueName).."; pac solution clone -p Both -o . -n $_.SolutionUniqueName -a -pca } } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'solution'
    $__commandArgs += 'list'
    $__commandArgs += '--json'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Exports Unmanaged solution to disk and unpacks it

#>
}


function Select-AuthProfile
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $selected = $input | ConvertFrom-TextTable -ColumnOffset 0,6,13,23,28,45,89,126 | sort -Property Friendly_Name | Out-ConsoleGridView -OutputMode Single; if($selected -ne $null) { Write-Host "Selecting Auth Profile $($selected.Friendly_Name).."; pac auth select -i $selected.Index.Substring(1,1) } } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'auth'
    $__commandArgs += 'list'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Selects a profile for authentication

#>
}


function Add-AuthProfiles
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $selected = $input | ConvertFrom-TextTable -ColumnOffset 0,17,54,97 | Out-ConsoleGridView; $selected | ForEach-Object { $env = [uri]$_.Environment_URL; Write-Host "Creating Auth Profile for $($_.Environment_URL).."; pac auth create -n $env.Host.Split(".")[0] -env $_.Environment_URL; }; pac auth list } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'org'
    $__commandArgs += 'list'
    $__commandArgs += '--xml'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Creates auth profiles for all environments user has access to

#>
}


function Get-Users
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter()]
[PSDefaultValue(Value="<fetch><entity name='systemuserroles'><link-entity name='systemuser' from='systemuserid' to='systemuserid' alias='systemuser'><attribute name='fullname'/><attribute name='systemuserid'/><attribute name='internalemailaddress'/><attribute name='isdisabled'/><order attribute='fullname'/></link-entity><link-entity name='role' from='roleid' to='roleid' alias='role'><attribute name='name'/><attribute name='roleid'/><order attribute='name'/></link-entity></entity></fetch>")]
[string]$Role = "<fetch><entity name='systemuserroles'><link-entity name='systemuser' from='systemuserid' to='systemuserid' alias='systemuser'><attribute name='fullname'/><attribute name='systemuserid'/><attribute name='internalemailaddress'/><attribute name='isdisabled'/><order attribute='fullname'/></link-entity><link-entity name='role' from='roleid' to='roleid' alias='role'><attribute name='name'/><attribute name='roleid'/><order attribute='name'/></link-entity></entity></fetch>"
    )

BEGIN {
    $__PARAMETERMAP = @{
         Role = @{
               OriginalName = '--xml'
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = '$args'
               ArgumentTransformType = 'inline'
               }
    }

    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $input | Select-Object -Skip 3 | ConvertFrom-TextTable -ColumnOffset 0,37,59,157,209,246,283 -ConvertPropertyValue | Select-Object @{N="User"; E={$_."systemuser.fullname"}}, @{N="Email"; E={$_."systemuser.internalemailaddress"}}, @{N="Role"; E={$_."role.name"}}, @{N="Disabled"; E={$_."systemuser.isdisabled"}} | Out-ConsoleGridView -OutputMode Multiple } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'org'
    $__commandArgs += 'fetch'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Get users and their associated roles

.PARAMETER Role




#>
}


function Get-UsersInRole
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter(Mandatory=$true)]
[string]$Role
    )

BEGIN {
    $__PARAMETERMAP = @{
         Role = @{
               OriginalName = '--xml'
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = ' param([string]$v) "<fetch><entity name=''systemuserroles''><link-entity name=''systemuser'' from=''systemuserid'' to=''systemuserid'' alias=''systemuser''><attribute name=''fullname''/><attribute name=''systemuserid''/><attribute name=''internalemailaddress''/><attribute name=''isdisabled''/><order attribute=''fullname''/></link-entity><link-entity name=''role'' from=''roleid'' to=''roleid'' alias=''role''><attribute name=''name''/><attribute name=''roleid''/><filter><condition attribute=''name'' operator=''eq'' value=''$($v)''/></filter><order attribute=''name''/></link-entity></entity></fetch>"'
               ArgumentTransformType = 'Inline'
               }
    }

    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = { $input | Select-Object -Skip 3 | ConvertFrom-TextTable -ColumnOffset 0,37,59,157,209,246,283 -ConvertPropertyValue | Select-Object @{N="User"; E={$_."systemuser.fullname"}}, @{N="Email"; E={$_."systemuser.internalemailaddress"}}, @{N="Disabled"; E={$_."systemuser.isdisabled"}} | Out-ConsoleGridView -OutputMode Multiple } }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'org'
    $__commandArgs += 'fetch'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "pac"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("pac $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "pac")) {
          throw "Cannot find executable 'pac'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "pac" $__commandArgs
            }
            else {
                & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "pac" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Get users and their associated roles

.PARAMETER Role
Name of role that is associated to the users.



#>
}


function Invoke-Echo
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter()]
[PSDefaultValue(Value="<fetch><entity name=''systemuserroles''><link-entity name=''systemuser'' from=''systemuserid'' to=''systemuserid'' alias=''systemuser''><attribute name=''fullname''/><attribute name=''systemuserid''/><attribute name=''internalemailaddress''/><attribute name=''isdisabled''/><order attribute=''fullname''/></link-entity><link-entity name=''role'' from=''roleid'' to=''roleid'' alias=''role''><attribute name=''name''/><attribute name=''roleid''/><order attribute=''name''/></link-entity></entity></fetch>")]
[string]$xml = "<fetch><entity name=''systemuserroles''><link-entity name=''systemuser'' from=''systemuserid'' to=''systemuserid'' alias=''systemuser''><attribute name=''fullname''/><attribute name=''systemuserid''/><attribute name=''internalemailaddress''/><attribute name=''isdisabled''/><order attribute=''fullname''/></link-entity><link-entity name=''role'' from=''roleid'' to=''roleid'' alias=''role''><attribute name=''name''/><attribute name=''roleid''/><order attribute=''name''/></link-entity></entity></fetch>",
[Parameter()]
[hashtable]$hasht1,
[Parameter()]
[System.Collections.Specialized.OrderedDictionary]$hasht2,
[Parameter()]
[string[]]$join,
[Parameter()]
[int]$mult2,
[Parameter()]
[int[]]$multmult1,
[Parameter()]
[int[]]$multmult2
    )

BEGIN {
    $__PARAMETERMAP = @{
         xml = @{
               OriginalName = '--xml'
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = ' param([string]$v) "<fetch><entity name=''systemuserroles''><link-entity name=''systemuser'' from=''systemuserid'' to=''systemuserid'' alias=''systemuser''><attribute name=''fullname''/><attribute name=''systemuserid''/><attribute name=''internalemailaddress''/><attribute name=''isdisabled''/><order attribute=''fullname''/></link-entity><link-entity name=''role'' from=''roleid'' to=''roleid'' alias=''role''><attribute name=''name''/><attribute name=''roleid''/><filter><condition attribute=''name'' operator=''eq'' value=''$($v)''/></filter><order attribute=''name''/></link-entity></entity></fetch>"'
               ArgumentTransformType = 'inline'
               }
         hasht1 = @{
               OriginalName = '--p1'
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'hashtable'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = 'param([hashtable]$v) $v.Keys.ForEach({''{0}={1}'' -f $_,$v[$_]}) -join '','''
               ArgumentTransformType = 'inline'
               }
         hasht2 = @{
               OriginalName = '--p1ordered'
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'System.Collections.Specialized.OrderedDictionary'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = 'param([System.Collections.Specialized.OrderedDictionary]$v) $v.Keys.ForEach({''{0}={1}'' -f $_,$v[$_]}) -join '','''
               ArgumentTransformType = 'inline'
               }
         join = @{
               OriginalName = '--p2'
               OriginalPosition = '1'
               Position = '2147483647'
               ParameterType = 'string[]'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = 'param([string[]]$v) $v -join '','''
               ArgumentTransformType = 'inline'
               }
         mult2 = @{
               OriginalName = '--p3'
               OriginalPosition = '2'
               Position = '2147483647'
               ParameterType = 'int'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = 'param([int]$v) $v * 2'
               ArgumentTransformType = 'inline'
               }
         multmult1 = @{
               OriginalName = '--p4'
               OriginalPosition = '3'
               Position = '2147483647'
               ParameterType = 'int[]'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = 'param([int[]]$v) $v.foreach({$_ * 2})'
               ArgumentTransformType = 'inline'
               }
         multmult2 = @{
               OriginalName = '--p5'
               OriginalPosition = '3'
               Position = '2147483647'
               ParameterType = 'int[]'
               ApplyToExecutable = $False
               NoGap = $False
               ArgumentTransform = 'param([int[]]$v) [string]::Join('','', $v.foreach({$_ * 2}))'
               ArgumentTransformType = 'inline'
               }
    }

    $__outputHandlers = @{ Default = @{ StreamOutput = $true; Handler = { $input; Pop-CrescendoNativeError -EmitAsError } } }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                if($param.ArgumentTransformType -eq 'inline') {
                   $transform = [scriptblock]::Create($param.ArgumentTransform)
                }
                else {
                   $transform = $param.ArgumentTransform
                }
                $__commandArgs += & $transform $value
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message "EchoTool"
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("EchoTool $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "EchoTool")) {
          throw "Cannot find executable 'EchoTool'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            if ( $null -eq $__handler ) {
                & "EchoTool" $__commandArgs
            }
            else {
                & "EchoTool" $__commandArgs 2>&1| Push-CrescendoNativeError | & $__handler
            }
        }
        else {
            $result = & "EchoTool" $__commandArgs 2>&1| Push-CrescendoNativeError
            & $__handler $result
        }
    }
  } # end PROCESS

<#
.SYNOPSIS
Argument 1 <-?>

.DESCRIPTION See help for EchoTool

.PARAMETER xml



.PARAMETER hasht1



.PARAMETER hasht2



.PARAMETER join



.PARAMETER mult2



.PARAMETER multmult1



.PARAMETER multmult2




#>
}


Set-Alias -Name 'pac-sol-unm' -Value 'Get-UnmanagedSolutions'
Set-Alias -Name 'pac-sol-man' -Value 'Get-ManagedSolutions'
Set-Alias -Name 'pac-sol-exp' -Value 'Export-Solutions'
Set-Alias -Name 'pac-sol-unp' -Value 'Expand-Solutions'
Set-Alias -Name 'pac-auth-sel' -Value 'Select-AuthProfile'
Set-Alias -Name 'pac-auth-add' -Value 'Add-AuthProfiles'
Set-Alias -Name 'pac-users' -Value 'Get-Users'
Set-Alias -Name 'pac-users-role' -Value 'Get-UsersInRole'
