# Script Name:  AD-user-onboarding.ps1
# Description:  Automates bulk Active Directory user creation and group assignment from a CSV file.

$CSVPath = "C:\Scripts\new_users.csv"
$Domain = "it.local"
$BaseOU = "OU=Employees,DC=it,DC=local"
$DefaultPassword = ConvertTo-SecureString "StartingPass123!" -AsPlainText -Force

if (-not (Test-Path $CSVPath)) {
    Write-Error "CSV file not found at $CSVPath"
    exit
}

$Users = Import-Csv -Path $CSVPath

foreach ($User in $Users) {
    $SamAccountName = ($User.FirstName.Substring(0,1) + "." + $User.LastName).ToLower()
    $UPN = "$SamAccountName@$Domain"
    $TargetOU = "OU=$($User.Department),$BaseOU"

    Write-Host "Processing: $($User.FirstName) $($User.LastName)..." -ForegroundColor Cyan

    if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'") {
        Write-Warning "User $SamAccountName already exists. Skipping."
        continue
    }

    try {
        $UserParams = @{
            Name                  = "$($User.FirstName) $($User.LastName)"
            GivenName             = $User.FirstName
            Surname               = $User.LastName
            SamAccountName        = $SamAccountName
            UserPrincipalName     = $UPN
            Path                  = $TargetOU
            AccountPassword       = $DefaultPassword
            ChangePasswordAtLogon = $true
            Enabled               = $true
            Title                 = $User.JobTitle
            Department            = $User.Department
        }

        New-ADUser @UserParams
        Write-Host "Successfully created user: $SamAccountName" -ForegroundColor Green

    }
    catch {
        Write-Error "Failed to create user $($User.FirstName): $($_.Exception.Message)"
    }
}

Write-Host "`n Onboarding Process Completed" -ForegroundColor Yellow
