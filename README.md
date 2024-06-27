# ZedRoProxy
```
Simple rotating proxies for windows written in ps1.
```
## Instructions
* Proxy List File:
  <br>Replace "C:\Path\To\proxy_list.txt" with the path to your proxy list file. The file should contain one proxy address per line (e.g., proxy1.example.com:8080).

* Usage:
  <br>Each time you run this script, it will rotate to the next proxy in the list.
  <br>If the script reaches the end of the list, it will cycle back to the beginning.

* Proxy Settings:
<br>The script modifies the proxy settings in the Windows Registry under HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings.
<br>It sets both HTTP and HTTPS proxy settings to the same value from the list.

* Internet Explorer Refresh:
<br>After setting the proxy, the script triggers a refresh of Internet Explorer's settings to apply the changes immediately.
