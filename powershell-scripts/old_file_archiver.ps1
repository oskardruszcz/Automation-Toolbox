# Script Name:  old_file_archiver.ps1
# Description:  Finds files older than X days, moves them to an archive and zips them.

$SourcePath = "C:\Shares\PublicDocs"
$ArchivePath = "C:\Archive\OldFiles_$(Get-Date -Format 'yyyy-MM-dd')"
$DaysOld = 90
$ZipFile = "$ArchivePath.zip"

if (-not (Test-Path $ArchivePath)) {
    New-Item -Path $ArchivePath -ItemType Directory | Out-Null
}

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

Write-Host "Compressing archive to $ZipFile..." -ForegroundColor Green
Compress-Archive -Path "$ArchivePath\*" -DestinationPath $ZipFile -Force

Write-Host "`n Archiving Process Completed" -ForegroundColor Yellow
