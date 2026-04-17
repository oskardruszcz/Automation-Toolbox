<#
.SYNOPSIS
    Archivies old files to a compressed ZIP folder.
.DESCRIPTION
    Scans a source directory for files older than a specific number of days, 
    moves them to an archive folder, and compresses them.
#>

# ==============================================================================
# Script Name:  Old-File-Archiver.ps1
# Description:  Finds files older than X days, moves them to an archive and zips them.
# ==============================================================================

# 1. Configuration
$SourcePath = "C:\Shares\PublicDocs"
$ArchivePath = "C:\Archive\OldFiles_$(Get-Date -Format 'yyyy-MM-dd')"
$DaysOld = 90
$ZipFile = "$ArchivePath.zip"

# Create archive directory if it doesn't exist
if (-not (Test-Path $ArchivePath)) {
    New-Item -Path $ArchivePath -ItemType Directory | Out-Null
}

# 2. Find and Move Files
$LimitDate = (Get-Date).AddDays(-$DaysOld)
Write-Host "Searching for files older than $LimitDate..." -ForegroundColor Cyan

$FilesToArchive = Get-ChildItem -Path $SourcePath -Recurse -File | Where-Object { $_.LastWriteTime -lt $LimitDate }

if ($FilesToArchive.Count -eq 0) {
    Write-Host "No old files found. Exiting." -ForegroundColor Yellow
    exit
}

foreach ($File in $FilesToArchive) {
    Write-Host "Archiving: $($File.Name)" -ForegroundColor Gray
    Move-Item -Path $File.FullName -Destination $ArchivePath -Force
}

# 3. Compress Archive
Write-Host "Compressing archive to $ZipFile..." -ForegroundColor Green
Compress-Archive -Path "$ArchivePath\*" -DestinationPath $ZipFile -Force

# 4. Cleanup (Optional: Remove the temporary folder after zipping)
Remove-Item -Path $ArchivePath -Recurse -Force

Write-Host "`n--- Archiving Process Completed ---" -ForegroundColor Yellow
