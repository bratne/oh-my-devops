function Test-WslDistroInstalled {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DistroName
    )

    wsl -l -q 2>$null | Where-Object { $_ -eq $DistroName } | ForEach-Object { return $true }
    return $false
}

function Install-WslDistroIfMissing {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$DistroName
    )

    Write-Verbose "Checking whether WSL distro '$DistroName' is installed..."

    if (Test-WslDistroInstalled -DistroName $DistroName) {
        Write-Host "WSL distro '$DistroName' is already installed. Skipping."
        return $false
    }

    Write-Host "WSL distro '$DistroName' is not installed. Installing..."

    if ($PSCmdlet.ShouldProcess("WSL distro '$DistroName'", "Install via 'wsl --install -d $DistroName'")) {
        try {
            # Capture stdout/stderr for logging if desired
            $output = & wsl --install -d $DistroName 2>&1

            # Show command output to the user
            if ($output) {
                $output | ForEach-Object { Write-Host $_ }
            }

            Write-Host "Installation command completed for '$DistroName'."
            return $true
        }
        catch {
            Write-Error "Failed to install WSL distro '$DistroName'. $($_.Exception.Message)"
            throw
        }
    }

    # If -WhatIf is used, we didn't actually install anything
    Write-Host "Installation skipped (WhatIf/confirmation)."
    return $false
}

function Ensure-WslDistroReady {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$DistroName
    )

    $justInstalled = Install-WslDistroIfMissing -DistroName "Debian"

    if ($justInstalled) {                
        Wait-WslDistroReady -DistroName "Debian"
    }
}

function Invoke-Wsl {
    param(
        [Parameter(Mandatory)][string]$DistroName,
        [string]$User = "root",
        [string]$WorkDir = "~",
        [Parameter(Mandatory)][string]$Command
    )

    # Use -- to keep argument parsing predictable.
    & wsl -d $DistroName --cd $WorkDir -u $User -- sh -lc $Command
    $code = $LASTEXITCODE
    if ($code -ne 0) {
        throw "WSL command failed (exit $code) in '$DistroName': $Command"
    }
}

function Configure-WslDistro {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$DistroName,
        [string]$ScriptRoot
    )

    if (-not $ScriptRoot) {
        $ScriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
    }
    
    Write-Host "Using ScriptRoot: $ScriptRoot"

    # Extract TEMP path from user env
    $tempPath = (Get-ChildItem Env:TEMP).Value
    $linTempPath = "/tmp/omdtmp"

    $steps = @(
        @("~", "apt-get update"),
        @("~", "DEBIAN_FRONTEND=noninteractive apt-get -y upgrade"),
        @("~", "apt-get install git make docker.io -y"),
        @("~", "cp `$(wslpath -u '$ScriptRoot') '$linTempPath'")
        @("~", "make -C '$gitDir'"),
    )
    
    foreach ($step in $steps) {
        $folder, $cmd = $step                
        Invoke-Wsl -DistroName $DistroName -User root -WorkDir $folder -Command $cmd
    }
}

# Example usage:
# Install-WSLFromFile -TarFilePath ".\distro.tar"
function Install-WSLFromFile {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$TarFilePath
    )

    # Ensure the script is running as Administrator
    if (-not ([Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw "Install-WSLFromFile must be run as Administrator."
    }

    # Resolve and validate file path
    $resolvedPath = Resolve-Path -Path $TarFilePath -ErrorAction Stop

    if (-not (Test-Path $resolvedPath)) {
        throw "File not found: $TarFilePath"
    }

    Write-Host "Installing WSL distribution from '$resolvedPath'..."
    wsl --install --from-file $resolvedPath
}

Ensure-WslDistroReady -DistroName "Debian"
Configure-WslDistro "Debian"
Install-WSLFromFile arch.tar