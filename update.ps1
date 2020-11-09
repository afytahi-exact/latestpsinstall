# Get current version based off pwsh.exe info 
$curVer = [string](gcm pwsh -errorAction SilentlyContinue).version

# Get latest version based off github repo metadata
$latVer = (irm https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json).ReleaseTag -replace "v"

# Test versions, if not latest then install latest, else report version is latest
if (!($curVer -like ($latVer + "*"))) {
	iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"
	
	# Restart Syncro Services
	get-service | ? {$_ -like "*Syncro*"} | restart-service
	
} else {
	write-host "Version is already the latest"
}
