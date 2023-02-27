@echo off
mode con:cols=50 lines=20
title A7 VPN
set vpnerror=0
echo Set WshShell = CreateObject("WScript.Shell") > "%temp%\Disconnect.vbs"
echo WshShell.Run chr(34) ^& "%temp%\Disconnect.bat" ^& Chr(34), ^0 >> "%temp%\Disconnect.vbs"
echo Set WshShell = Nothing >> "%temp%\Disconnect.vbs"
echo :loop > "%temp%\Disconnect.bat"
echo powershell -command "get-process | ?{$_.path -eq '%~F0'}" ^| findstr /l ProcessName >> "%temp%\Disconnect.bat"
echo if errorlevel 1 (goto Disconnect) else (goto loop) >> "%temp%\Disconnect.bat"
echo :Disconnect >> "%temp%\Disconnect.bat"
echo rasdial "A7 VPN" /Disconnect ^>NUL >> "%temp%\Disconnect.bat"
echo powershell -command "Remove-VpnConnection -Force -Name 'A7 VPN'" ^>NUL >> "%temp%\Disconnect.bat"
echo del Disconnect.vbs ^& del %%0 ^& exit >> "%temp%\Disconnect.bat"
cd "%temp%" & start Disconnect.vbs
:server
ping -n 1 -l 1 google.com >nul
if errorlevel 1 ping -n 1 -l 1 google.com >nul
if errorlevel 1 ping -n 1 -l 1 google.com >nul
if errorlevel 1 ping -n 1 -l 1 google.com >nul
if errorlevel 1 (color CF
:error1
mode con:cols=50 lines=20
cls & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo              No internet connection & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & timeout 2 >nul
goto error1
)
if %vpnerror%==0 (
rasdial "A7 VPN" /DISCONNECT >NUL
powershell -command "Remove-VpnConnection -Force -Name 'A7 VPN'" >NUL
powershell -command "Add-VpnConnection -Name 'A7 VPN' -ServerAddress 'server1.freevpn.me'" >NUL
cls & color 9F & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo              Connecting to A7 VPN... & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo.
rasdial "A7 VPN" "freevpn.me" "hRfV4Jnt6e" >NUL
FOR /F "tokens=*" %%g IN ('powershell -command "Get-VpnConnection -Name 'A7 VPN'" ^| findstr /l "ConnectionStatus"') do (if not "%%g"=="ConnectionStatus      : Connected" (cls & set /a vpnerror=vpnerror+1 & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & color CF & echo  Connection failed, trying with another server... & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & goto server))
goto vpnconnect
)
if %vpnerror%==6 (color CF
:error2
mode con:cols=50 lines=20
cls & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo    Perhaps there are problems on the Internet & echo. & echo              please try again later & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & timeout 2 >nul
goto error2
)
FOR /F %%A IN ('powershell.exe -Command "Get-Random -Minimum 1 -Maximum 261"') DO SET vpn1=%%A
rasdial "A7 VPN" /DISCONNECT >NUL
powershell -command "Remove-VpnConnection -Force -Name 'A7 VPN'" >NUL
powershell -command "Add-VpnConnection -Name 'A7 VPN' -ServerAddress 'public-vpn-%vpn1%.opengw.net'" >NUL
cls & color 9F & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo              Connecting to A7 VPN... & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo.
rasdial "A7 VPN" "vpn" "vpn" >NUL
FOR /F "tokens=*" %%g IN ('powershell -command "Get-VpnConnection -Name 'A7 VPN'" ^| findstr /l "ConnectionStatus"') do (if not "%%g"=="ConnectionStatus      : Connected" (cls & set /a vpnerror=vpnerror+1 & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & color CF & echo  Connection failed, trying with another server... & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & goto server))
:vpnconnect
set s=0& set m=0& set h=0& set ss=:0& set mm=:0& set hh=[0
cls & echo. & echo. & echo. & echo. & echo. & echo. & color AF & echo                    %hh%%h%%mm%%m%%ss%%s%] & echo. & echo         Successfully connected to A7 VPN & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo.
ping localhost -n 2 > nul
:time
mode con:cols=50 lines=20
set /a s=s+1
if %s%==60 set /a m=m+1 & set s=0
if %m%==60 set /a h=h+1 & set m=0
if %s% GTR 9 (set ss=:) else (set ss=:0)
if %m% GTR 9 (set mm=:) else (set mm=:0)
if %h% GTR 9 (set hh=[) else (set hh=[0)
cls & echo. & echo. & echo. & echo. & echo. & echo. & echo                    %hh%%h%%mm%%m%%ss%%s%] & echo. & echo         Successfully connected to A7 VPN & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo.
ping localhost -n 2 > nul
goto time