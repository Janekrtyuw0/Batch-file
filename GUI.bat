@echo off
:menu

title pro hacker console
chcp 65001 >nul
echo.
echo.
echo.
echo [34m	 __  __  _  _  __   ____  __  ____  __    __  __   [0m
echo [34m	(  \/  )( )( )(  ) (_  _)(  )(_  _)/  \  /  \(  )  [0m
echo [34m	 )    (  )()(  )(__  )(   )(   )( ( () )( () ))(__ [0m
echo [34m	(_/\/\_) \__/ (____)(__) (__) (__) \__/  \__/(____)[0m
echo.
echo.
echo.
echo [1] Notification
echo [2] Message Box
echo [3] Input Box 
echo [4] Window 
echo [5] Clear temp 
echo [6] IP Address 
echo [7] Password generator 
echo [8] MSinfo32
echo [9] IP addresses scanner
 
set /p input=">>"
if %input% EQU 1 goto Noti
if %input% EQU 2 goto msgbox				
if %input% EQU 3 goto inputbox
if %input% EQU 4 goto window
if %input% EQU 5 goto temp
if %input% EQU 6 goto ip
if %input% EQU 7 goto passwd generator
if %input% EQU 8 goto msinfo
if %input% EQU 9 goto ip_addresses_scanner

:ip_addresses_scanner
cls
REM Pobieranie adresu IP urządzenia
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set ip=%%a
)

REM Usuwanie spacji na początku
set ip=%ip:~1%

REM Wyodrębnienie części sieciowej (pierwsze trzy oktety)
for /f "tokens=1-3 delims=." %%a in ("%ip%") do (
    set network=%%a.%%b.%%c
)

echo Skanuje siec: %network%.0/24

REM Skanowanie adresów IP w zakresie od .1 do .254
for /L %%i in (1,1,254) do (
    ping -n 1 -w 5 %network%.%%i >nul
    if not errorlevel 1 echo Adres IP %network%.%%i jest aktywny
)

echo Skonczono skanowanie sieci.
pause
cls
goto menu


:msinfo
cls
start MSinfo32
cls
goto menu
:passwd generator
cls
setlocal EnableDelayedExpansion
chcp 1257

set alpha="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-!@#$%^&*()"
set alphaCnt=68

For /L %%j in (1,1,10) DO CALL :GEN %%j

pause
Goto :Eof
:GEN
Set "Password="
For /L %%j in (1,1,10) DO (
    Set /a i=!random! %% alphaCnt
    Call Set PASSWORD=!PASSWORD!%%alpha:~!i!,1%%
)
echo Your Random Password %1 is [%PASSWORD%]
pause
cls
goto menu

:ip
cls
:loop
cls
echo Hi, this is your IP:
ipconfig > elo.log
 findstr "Ethernet Subnet IPv4" elo.log

pause
start elo.log
cls
goto menu

:temp
cls
cd /d %temp%
del /f /s /q *.*
for /d %%x in (*) do rd /s /q "%%x"
echo Temporary files deleted.
pause
cls
goto menu

:window
cls
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $mainForm = New-Object System.Windows.Forms.Form; $mainForm.Text = 'Main Window'; $lbl = New-Object System.Windows.Forms.Label; $lbl.Text = 'Welcome to hell Sir!'; $mainForm.Controls.Add($lbl); $mainForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; $mainForm.ShowDialog()}"
cls
goto menu
:inputbox
cls
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Enter your name:', 'Hello')}" > %TEMP%\out.tmp
set /p OUT=<%TEMP%\out.tmp
set msgBoxArgs="& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('You have entered: %OUT%', 'Welcome to hell Sir!');}"
powershell -Command %msgBoxArgs%
cls
goto menu

:msgbox
cls
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Upgrading from Windows 10 to Windows 11...', 'Windows', 'OKCancel', [System.Windows.Forms.MessageBoxIcon]::Information);}"
cls
goto menu


:Noti
cls
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Warning; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Windows Defender', '8 Trojans detected', [System.Windows.Forms.ToolTipIcon]::None)}"
cls
goto menu