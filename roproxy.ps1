# Define the path to the proxy list file
$proxyListFile = "C:\Path\To\proxy_list.txt"

# Read the proxy list from the file
$proxyList = Get-Content -Path $proxyListFile

# Get the current proxy settings
$currentProxyIndex = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -ErrorAction SilentlyContinue

if ($currentProxyIndex -eq $null) {
    $currentProxyIndex = -1  # Start with no proxy set
} else {
    $currentProxyIndex = [int]$currentProxyIndex.Split("=")[-1]  # Extract the index of the current proxy
}

# Calculate the next proxy index
$nextProxyIndex = ($currentProxyIndex + 1) % $proxyList.Count

# Set the new proxy
if ($nextProxyIndex -lt $proxyList.Count) {
    $proxyServer = $proxyList[$nextProxyIndex]
    Write-Output "Setting proxy to: $proxyServer"

    # Set the proxy settings
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "http=$proxyServer;https=$proxyServer;"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1

    # Refresh the Internet Explorer settings
    Start-Process -FilePath "rundll32.exe" -ArgumentList "shell32.dll,Control_RunDLL inetcpl.cpl,,4"
} else {
    Write-Output "No more proxies available."
}
