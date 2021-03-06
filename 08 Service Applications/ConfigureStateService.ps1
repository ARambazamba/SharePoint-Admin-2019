if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) {
    Add-PSSnapin "Microsoft.SharePoint.PowerShell"
}

# Configure State Service
$serviceApp = New-SPStateServiceApplication -Name "State Service Application"
New-SPStateServiceDatabase -Name "SharePoint_Service_State" -ServiceApplication $serviceApp
New-SPStateServiceApplicationProxy -Name "State Service Application Proxy" -ServiceApplication $serviceApp -DefaultProxyGroup