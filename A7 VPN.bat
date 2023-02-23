@echo off
mode con:cols=50 lines=20
title A7 VPN
color 1F
:server
FOR /F %%A IN ('powershell.exe -Command "Get-Random -Minimum 1 -Maximum 261"') DO SET vpn1=%%A
rasdial "A7 VPN" /DISCONNECT >NUL
powershell -command "Remove-VpnConnection -Force -Name 'A7 VPN'" >NUL
powershell -command "Add-VpnConnection -Name 'A7 VPN' -ServerAddress 'public-vpn-%vpn1%.opengw.net' -TunnelType Sstp" >NUL
cls
echo.
echo.
echo              Connecting to A7 VPN...
echo.
FOR /F "tokens=*" %%g IN ('rasdial "A7 VPN" "vpn" "vpn"') do (SET vpn2=%%g)
if not "%vpn2%"=="Command completed successfully." echo  Connection failed, trying with another server... & goto server
echo         Successfully connected to A7 VPN
echo.
echo            Press any key to exit . . .
set /p press=
exit