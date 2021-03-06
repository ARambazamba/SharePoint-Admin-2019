if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) {
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

# Configure Subscription Settings

$account = Get-SPManagedAccount "spdom\spservice" 

$subsSettingsService = "SettingsServiceApp"
$subsSettingsServiceDB = "SettingsServiceDB"
$subsSettingsServicePool = "SettingsServiceAppPool"

$appPoolSubSvc = New-SPServiceApplicationPool -Name $subsSettingsServicePool -Account $account
$appSubSvc = New-SPSubscriptionSettingsServiceApplication –ApplicationPool $appPoolSubSvc –Name $subsSettingsService –DatabaseName $subsSettingsServiceDB
New-SPSubscriptionSettingsServiceApplicationProxy –ServiceApplication $appSubSvc

Write-Host Created $subsSettingsService 

# Configure App Management Service

$appPoolAppSvc = New-SPServiceApplicationPool -Name AppServiceAppPool -Account $account
$appAppSvc = New-SPAppManagementServiceApplication -ApplicationPool $appPoolAppSvc -Name AppServiceAppx -DatabaseName "AppServiceDB"
New-SPAppManagementServiceApplicationProxy -ServiceApplication $appAppSvc