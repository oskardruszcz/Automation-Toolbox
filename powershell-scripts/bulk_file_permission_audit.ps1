# Script Name:  Bulk-File-Permission-Audit.ps1
# Description:  Scans directories for insecure NTFS permissions (e.g., Everyone group).

$TargetRoot = "C:\Shares\Departmental"
$ReportPath = "$PSScriptRoot\Permissions_Audit_$(Get-Date -Format 'yyyyMMdd').csv"

if (-not (Test-Path $TargetRoot)) {
    Write-Error "Target directory not found: $TargetRoot"
    exit
}

Write-Host "Starting Permission Audit on $TargetRoot" -ForegroundColor Cyan
$Results = @()

$Folders = Get-ChildItem -Path $TargetRoot -Recurse -Directory

foreach ($Folder in $Folders) {
    Write-Host "Auditing: $($Folder.FullName)" -ForegroundColor Gray
    
    $Acl = Get-Acl -Path $Folder.FullName
    
    foreach ($Access in $Acl.Access) {
        $Identity = $Access.IdentityReference.Value
        
        $IsRisk = $false
        if ($Identity -match "Everyone" -or $Identity -match "Anonymous" -or $Identity -match "Guest") {
            $IsRisk = $true
            Write-Host "SECURITY RISK: $Identity found on $($Folder.Name)" -ForegroundColor Red
        }

        $Object = [PSCustomObject]@{
            FolderName    = $Folder.FullName
            Identity      = $Identity
            Permissions   = $Access.FileSystemRights
            AccessType    = $Access.AccessControlType
            Inherited     = $Access.IsInherited
            SecurityRisk  = $IsRisk
        }
        $Results += $Object
    }
}

if ($Results) {
    $Results | Export-Csv -Path $ReportPath -NoTypeInformation -Encoding UTF8
    Write-Host "`n Audit complete. Report saved to: $ReportPath" -ForegroundColor Green
} else {
    Write-Host "No directories found to audit." -ForegroundColor Yellow
}

Write-Host "`n Permission Audit Process Completed" -ForegroundColor Yellow
