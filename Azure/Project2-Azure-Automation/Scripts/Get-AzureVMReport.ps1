# ============================================================
# Azure VM Operations Report
# Project2 - Azure Operations Automation
# ============================================================

$ErrorActionPreference = "Stop"

# Output paths
$ReportPath = Join-Path $PSScriptRoot "..\Reports\AzureVMReport.csv"
$LogPath    = Join-Path $PSScriptRoot "..\ExecutionLogs\Automation.log"

# Normalize paths
$ReportPath = [System.IO.Path]::GetFullPath($ReportPath)
$LogPath    = [System.IO.Path]::GetFullPath($LogPath)

function Write-Log {
    param (
        [string]$Message
    )

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "[$Timestamp] $Message"

    Write-Host $LogMessage
    Add-Content -Path $LogPath -Value $LogMessage
}

try {

    Write-Log "Azure VM report started."

    # Check Azure CLI
    az version | Out-Null

    if ($LASTEXITCODE -ne 0) {
        throw "Azure CLI is not available."
    }

    Write-Log "Azure CLI check: OK"

    # Check Azure login
    $Account = az account show --output json | ConvertFrom-Json

    if (-not $Account) {
        throw "Azure account information could not be retrieved."
    }

    Write-Log "Azure subscription: $($Account.name)"

    # Get VM information
    $VMs = az vm list --show-details --output json | ConvertFrom-Json

    if (-not $VMs) {
        Write-Log "No Azure VMs were found."
        exit 0
    }

    $Report = foreach ($VM in $VMs) {

        [PSCustomObject]@{
            Name          = $VM.name
            ResourceGroup = $VM.resourceGroup
            Location      = $VM.location
            VMSize        = $VM.hardwareProfile.vmSize
            PowerState    = $VM.powerState
            PrivateIP     = $VM.privateIps
            PublicIP      = $VM.publicIps
        }
    }

    # Export CSV
    $Report | Export-Csv `
        -Path $ReportPath `
        -NoTypeInformation `
        -Encoding UTF8

    Write-Log "Report exported: $ReportPath"
    Write-Log "Azure VM report completed successfully."

}
catch {

    Write-Log "ERROR: $($_.Exception.Message)"
    exit 1
}