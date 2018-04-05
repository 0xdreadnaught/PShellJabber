#Jabber "Fix"

#Kill Jabber before we wipe the cache
if (Get-Process firefox -ErrorAction SilentlyContinue){
	kill -ProcessName CiscoJabber
}

#Delete the cache. This whill throw errors if the folders are gone. ignore them
Write-Host "Deleting - C:\Users\$($env:UserName)\AppData\Local\Cisco\Unified Communications\Jabber"
Remove-Item -path "C:\Users\$($env:UserName)\AppData\Local\Cisco\Unified Communications\Jabber" -recurse
Write-Host "Complete ..."
Write-Host "Deleting - C:\Users\$($env:UserName)\AppData\Roaming\Cisco\Unified Communications\Jabber"
Remove-Item -path "C:\Users\$($env:UserName)\AppData\Roaming\Cisco\Unified Communications\Jabber" -recurse
Write-Host "Complete ..."

#Start Jabber
Start-Process "C:\Program Files (x86)\Cisco Systems\Cisco Jabber\CiscoJabber.exe"

#Wait to make sure it's finished booting up
Start-Sleep -Seconds 4

#Create shell object for key input
$myshell = New-Object -com "Wscript.Shell"

#Enter fake credentials
$msg = "1234567890@mil" ############################################################ REPLACE THIS WITH YOUR ID NUMBER. LEAVE @MIL 
$msg = $msg.toCharArray()

foreach ($letter in $msg) {
  $myshell.SendKeys($letter)
  Start-Sleep -Milliseconds 100
}
$myshell.SendKeys("{TAB}")
foreach ($letter in $msg) {
  $myshell.SendKeys($letter)
  Start-Sleep -Milliseconds 100
}
$myshell.SendKeys("{ENTER}")

#Wait for it to return an error
Start-Sleep -Seconds 4

#Kill and relaunch Jabber
kill -ProcessName ciscojabber
Start-Process "C:\Program Files (x86)\Cisco Systems\Cisco Jabber\CiscoJabber.exe"



