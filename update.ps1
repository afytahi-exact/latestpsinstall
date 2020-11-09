$curVer = [string](gcm pwsh -errorAction SilentlyContinue).version
$latVer = (irm https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json).ReleaseTag

if (!($curVer -like ($latVer + "*"))) {
	iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"
} else {
	write-host "Version is already the latest"
}
