<#
.SYNOPSIS
Runs code to put your system back to its original state after running tests.

.DESCRIPTION
In order for DSC tests to run, Carbon must be in a known PSModulePath. On developer computers, the `Start-CarbonTest.ps1` script creates a junction in the module installation directory. This script removes that junction.

#>
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
[CmdletBinding()]
param(
)

#Requires -Version 5.1
Set-StrictMode -Version 'Latest'

$psModulesPath = Join-Path -Path $PSScriptRoot -ChildPath 'Carbon.DSC' -Resolve

Import-Module -Name (Join-Path -Path $psModulesPath -ChildPath 'Carbon' -Resolve) `
              -Function @('Get-CPowerShellModuleInstallPath', 'Uninstall-CJunction') `
              -Verbose:$false

$installRoot = Get-CPowerShellModuleInstallPath
$carbonModuleRoot = Join-Path -Path $installRoot -ChildPath 'Carbon.DSC'
Uninstall-CJunction -Path $carbonModuleRoot
