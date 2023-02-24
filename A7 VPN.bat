@echo off
mode con:cols=50 lines=20
title A7 VPN
ping -n 1 -l 1 google.com >nul
if errorlevel 1 (color CF & echo. & echo. & echo              No internet connection & echo. & echo               Press [Enter] to exit & set /p press= & exit) else (color 9F)
:server
FOR /F %%A IN ('powershell.exe -Command "Get-Random -Minimum 1 -Maximum 261"') DO SET vpn1=%%A
rasdial "A7 VPN" /DISCONNECT >NUL
powershell -command "Remove-VpnConnection -Force -Name 'A7 VPN'" >NUL
powershell -command "Add-VpnConnection -Name 'A7 VPN' -ServerAddress 'ppublic-vpn-%vpn1%.opengw.net' -TunnelType Sstp" >NUL
cls & echo. & echo. & echo              Connecting to A7 VPN... & echo.
rasdial "A7 VPN" "vpn" "vpn" >NUL
FOR /F "tokens=*" %%g IN ('powershell -command "Get-VpnConnection -Name 'A7 VPN'" ^| findstr /l "ConnectionStatus"') do (if not "%%g"=="ConnectionStatus      : Connected" (echo  Connection failed, trying with another server... & goto server) else (color AF & echo         Successfully connected to A7 VPN & echo. & echo               Press [Enter] to exit & set /p press= & exit))
