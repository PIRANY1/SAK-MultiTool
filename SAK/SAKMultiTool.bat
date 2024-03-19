:: Make the Script easier to test and Debug
@if not defined debug_assist (@ECHO OFF) else (@echo on)
if not defined devtools (goto home) else (goto dtd)

:home
if not exist bin mkdir bin
cd bin
if not exist accountinfo mkdir accountinfo
if not exist logs mkdir logs
cd %~dp0
echo %username% opened SAK on %date%%time% > startlog%date%%time%.txt
set /p date-account-created=<%cd%\bin\accountinfo\datecreated.txt
set /p ip-account-created=<%cd%\bin\accountinfo\ip.txt

cls
powershell -window normal -command ""
title SAK BETA 0.4.4 // @pfpz // @pirany1
color c0
echo ________________________________________________________________
echo _____/\\\\\\\\\\\_______/\\\\\\\\\_____/\\\________/\\\_________        
echo ____/\\\/////////\\\___/\\\\\\\\\\\\\__\/\\\_____/\\\//_________      
echo ____\//\\\______\///___/\\\/////////\\\_\/\\\__/\\\//___________      
echo ______\////\\\_________\/\\\_______\/\\\_\/\\\\\\//\\\__________     
echo __________\////\\\______\/\\\\\\\\\\\\\\\_\/\\\//_\//\\\________    
echo ______________\////\\\___\/\\\/////////\\\_\/\\\____\//\\\______   
echo ________/\\\______\//\\\__\/\\\_______\/\\\_\/\\\_____\//\\\____  
echo ________\///\\\\\\\\\\\/___\/\\\_______\/\\\_\/\\\______\//\\\__ 
echo ___________\///////////_____\///________\///__\///________\///__
echo ________________________________________________________________
echo    Please login using the message boxes that have been opened:     
echo ________________________________________________________________ 
if not exist %cd%\bin\accountinfo\user.txt goto startfail
goto home2

:startfail
mkdir %cd%\bin\logs\faillog%date%%time%
echo %username% failed a start due to no account on %date%%time% > %cd%\bin\logs\faillog%date%%time%\faillog%date%%time%.txt
powershell -window normal -command ""
msg * /TIME:5 "There was an error while starting SAK, it would appear there is no accounts currently created. Create one now!"

:home2
set /p passfile=<%cd%\bin\accountinfo\pass.txt
set /p userfile=<%cd%\bin\accountinfo\user.txt
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; Add-Type -AssemblyName System.Windows.Forms; [Microsoft.VisualBasic.Interaction]::InputBox('Enter your username:', 'SAK BETA 0.4.4 Login', ''); $mainForm.Controls.Add($lbl); $mainForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; $mainForm.ShowDialog()}" > %TEMP%\user.tmp 
set /p user=<%TEMP%\user.tmp                                                                                             
if not %user%==%userfile% goto fail
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; Add-Type -AssemblyName System.Windows.Forms; [Microsoft.VisualBasic.Interaction]::InputBox('Enter your password:', 'SAK BETA 0.4.4 Login'); $mainForm.Controls.Add($lbl); $mainForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; $mainForm.ShowDialog()}" > %TEMP%\pass.tmp 
set /p pass=<%TEMP%\pass.tmp 
if not %pass%==%passfile% goto fail 
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set local_ip=%%a
set ip=%local_ip%  
goto BREAK2


:BREAK2
mkdir %cd%\bin\logs\goodlog%date%%time%
echo %username% logged in on %date%%time% with username %user% and password %pass% >%cd%\bin\logs\goodlog%date%%time%\goodlog%date%%time%.txt
goto menu



:loggedout
cls
mkdir %cd%\bin\logs\startlog%date%%time%
echo %ipfile% logged out of %userfile% on %date%%time% >%cd%\bin\logs\startlog%date%%time%\startlog%date%%time%.txt
powershell -window normal -command ""
echo You are now logged out of %username%...
timeout /t 3 /nobreak
goto home

:fail
cls
powershell -window minimized -command ""
cls
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set local_ip=%%a
set ip=%local_ip%  
goto BREAK


:BREAK
mkdir %cd%\bin\logs\badlog%date%%time%
echo %ip% failed a log in on %date%%time% with username %user% and password %pass% >%cd%\bin\logs\badlog%lognum%\badlog%lognum%.txt
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Your login has failed. Press Ok to retry or Cancel to close SAK. If error persists contact @pfpz', 'Login error: ', 'OkCancel', [System.Windows.Forms.MessageBoxIcon]::Warning; $mainForm.Controls.Add($lbl); $mainForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; $mainForm.ShowDialog()}" > %TEMP%\out45.tmp
set /p OUT45=<%TEMP%\out45.tmp
if %OUT45%==OK goto home
if %OUT45%==Cancel exit
if %OUT45%==X exit
timeout /t 1 /nobreak
goto home

:menu
cls
powershell -window normal -command ""
color c0
mode con:cols=100 lines=30
title SAK BETA 0.4.4 Directory // @pfpz
echo Current User: %userfile%
echo ----------------------------------------------------------------------------------------
echo  !!!!!!!!!!!!!!!!!!!!! SAK Multi Tool (Swiss army knife) is a tool !!!!!!!!!!!!!!!!!!!!
echo  !  Swiss Army Knife ! coded in batch for Windows based devices    ! Swiss Army Knife !
echo  !     Multi Tool    ! to help in Network based white hat hacking  !     Multi Tool   !
echo  !    Made by @pfpz  ! and pen testing. SAK can also be used for   !   Made by @pfpz  !
echo  !!!!!!!!!!!!!!!!!!!!! many more educational uses! Check it out:   !!!!!!!!!!!!!!!!!!!!
echo ----------------------------------------------------------------------------------------
echo  Please select a Tool you would like to use down below !! Follow TikTok @pfpz for more!
echo -----------------------------------------------------------------------------------------
echo      [RAINBOW Pinger] - 1 // [IP Tracker] - 2 // [Wifi Recovery] - 3 // [Logout] - 4 
echo -----------------------------------------------------------------------------------------
echo            [Browser] - 5 // [Exit] - 6 // [News] - 7 // [Account Manager] - 8
echo
set /p menuans=Directory selection: 
if %menuans%==1 goto rainbowp
if %menuans%==2 goto tracker
if %menuans%==3 goto wifirec
if %menuans%==4 goto loggedout
if %menuans%==5 goto browser
if %menuans%==6 exit 
if %menuans%==7 goto newstab
if %menuans%==8 goto homesaklic
if %menuans%==123 goto menu

:newstab
cls
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Major bug fixes and feedback control fixes. Major UI and GUI changes. Stay up to date with all new features and updates by following my TikTok @pfpz', 'SAK BETA 0.4.4 News & Patch Notes', 'OK'); [System.Windows.Forms.MessageBoxIcon]::Information; $mainForm.Controls.Add($lbl); $mainForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; $mainForm.ShowDialog()}" > %TEMP%\out96.tmp
set /p out96=<%TEMP%\out96.tmp
if %out96%==OK goto menu
if %out96%==X goto menu

:rainbowp
cls
color 0c
title SAK BETA 0.4.4 RAINBOW Pinger! // @pfpz
mode con:cols=100 lines:60 
echo !!!!!!!!!!!!!!!!!!!!! 
echo !  Swiss Army Knife !
echo !     Multi Tool    !
echo !    Made by @pfpz  !
echo !!!!!!!!!!!!!!!!!!!!! PRESENTS:
echo --------------------------------------------------------------------------------
echo RAINBOW Pinger!
echo Enter any IP or address below and behold as the rainbowness takes you away!
echo --------------------------------------------------------------------------------
set /p IP=Enter your target's IP: 
goto pinger

:pinger
cls
mode con:cols=60 lines=40
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline. 
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color a
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 02
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online. 
ping -t 2 0 10 127.0.0.1 >nul
color 03
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online. 
ping -t 2 0 10 127.0.0.1 >nul
color 04
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 05
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 06
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online. 
ping -t 2 0 10 127.0.0.1 >nul
color 07
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online. 
ping -t 2 0 10 127.0.0.1 >nul
color 08
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online. 
ping -t 2 0 10 127.0.0.1 >nul
color 09
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 0a
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 0b
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 0c
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 0d
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 0e
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
color 0f
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 echo Your target %ip% is offline.
IF not ERRORLEVEL 1 echo Your Target %ip% is online.
ping -t 2 0 10 127.0.0.1 >nul
goto pinger

:tracker
cls
color c0
mode con:cols=60 lines:40 
title SAK BETA 0.4.4 IP Tracker // @pfpz
echo !!!!!!!!!!!!!!!!!!!!!
echo !  Swiss Army Knife !
echo !     Multi Tool    !
echo !    Made by @pfpz  !
echo !!!!!!!!!!!!!!!!!!!!! PRESENTS:
echo ------------------------------------------------------
echo IP Tracker BETA 2.0 (Powered by ipinfo.io)
echo ------------------------------------------------------
set /p trackd=Enter your target's IP: 
goto tracked

:tracked
cls
color 0c
mode con:cols=80 lines:40 
title SAK BETA 0.4.4 IP Tracker // @pfpz
echo !!!!!!!!!!!!!!!!!!!!!
echo !  Swiss Army Knife !
echo !     Multi Tool    !
echo !    Made by @pfpz  !
echo !!!!!!!!!!!!!!!!!!!!! PRESENTS:
echo ----------------------------------------------------------------------------------
echo IP Tracker BETA 1.1 (Powered by ipinfo.io)
echo ----------------------------------------------------------------------------------
echo Your target's information has been gathered at ipinfo.io/%trackd%
echo ----------------------------------------------------------------------------------
set /p tracked2=Do you wish to track another IP (1) or go back to the directory (2)?: 
if %tracked2%==1 goto tracker
if %tracked2%==2 goto menu

:wifirec
cls
title SAK BETA 0.4.4 Wifi Recovery // @pfpz
echo !!!!!!!!!!!!!!!!!!!!!
echo !  Swiss Army Knife !
echo !     Multi Tool    !
echo !    Made by @pfpz  !
echo !!!!!!!!!!!!!!!!!!!!! PRESENTS:
echo ---------------------------------------------------------------------------------------
mode con:cols=140 lines=40
echo Welcome to SAK Wifi Recovery! Here is a list of your saved wifi networks and passwords:
echo ---------------------------------------------------------------------------------------
setlocal enabledelayedexpansion

for /F "tokens=2 delims=:" %%a in ('netsh wlan show profile') do (
    set wifi_pwd=
    for /F "tokens=2 delims=: usebackq" %%F IN (`netsh wlan show profile %%a key^=clear ^| find "Key Content"`) do (
        set wifi_pwd=%%F
    )
    echo %%a : !wifi_pwd!       // 
)
echo ---------------------------------------------------------------------------------------
echo (d)irectory or (e)xit
echo ---------------------
set /p redirect=Where to now?: 
if %redirect%==d goto menu
if %redirect%==e exit

:browser
cls
color 90
title SAK.SBB (Browser) // @pfpz
echo !!!!!!!!!!!!!!!!!!!!!
echo !  Swiss Army Knife !
echo !     Multi Tool    !
echo !    Made by @pfpz  !
echo !!!!!!!!!!!!!!!!!!!!! PRESENTS:
echo ------------------------------------------------------------
echo Welcome to SAK Smart Batch Browser, or SAK.SBB for short!
echo ------------------------------------------------------------
echo Enter (D) for directory or (E) to exit!
echo ------------------------------------------------------------
set /p browserq=What would you like to look up?: 
if %browserq%==e exit 
if %browserq%==d goto menu
goto browserdone

:browserdone
cls
color 90
title SAK.SBB (Browser) // @pfpz
echo !!!!!!!!!!!!!!!!!!!!!
echo !  Swiss Army Knife !
echo !     Multi Tool    !
echo !    Made by @pfpz  !
echo !!!!!!!!!!!!!!!!!!!!! PRESENTS: 
echo -------------------------------------------------------------------------------
echo Welcome to SAK Smart Batch Browser, or SAK.SBB for short!
echo -------------------------------------------------------------------------------
echo Now redirecting you to http://www.google.pt/search?q=%browserq%...
echo -------------------------------------------------------------------------------
:: Why use a 32563465 Line PS code when you can use explorer
explorer http://www.google.pt/search?q=%browserq%
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'SAK.SBB', 'Your search is now done.', [System.Windows.Forms.ToolTipIcon]::Information)}"
goto browser

:homesaklic
cd %~dp0
title SAK Account Manager // @pfpz
cls
color 0a
cls
if exist %cd%\bin\accountinfo\user.txt (echo Current user is %userfile%) else echo There is currently no accounts created on this device
echo Create an account now if this is your first time or make a new account! (E)xit \ (S)AK
echo -------------------------------------------------------------------------------------------
set /p choice=Do you want to (C)reate a new account, (D)elete an account, or see account (I)nfo?: 
if %choice%==c goto accountcreate
if %choice%==d goto accountdelete
if %choice%==e exit
if %choice%==i goto accinfo
( if %choice%==s if exist %cd%\bin\accountinfo\user.txt goto menu 
    if not exist %cd%\bin\accountinfo\user.txt goto accountcreate )

:accountcreate
title if u see this hi lol
if not exist C:\SAK\bin\accountinfo mkdir C:\SAK\bin\accountinfo
if not exist C:\SAK\bin\logs mkdir C:\SAK\bin\logs
if exist C:\SAK\bin\accountinfo\user.txt goto createfail
if not exist C:\SAK\bin\accountinfo\user.txt goto accountcreate1

:createfail
cls
color 0c
title Account Creation Failed: // @pfpz
echo Your account creation has failed, refer to the popup message on your screen for information.
echo Contact @pfpz if your issue persists
msg * /TIME:5 "There is already an account created on this device, enter (I) if you forgot your password or (D) to delete your account and create a new one.",16, "Account Creation Error:"
goto homesaklic

:accountcreate1
cd %~dp0
cls
color 0a
title SAK Account Creator // @pfpz
echo Create a new account below!
set /p user=Enter username: 
set /p pass=Enter password: 
echo %user% > %cd%\bin\accountinfo\user.txt
echo %pass% > %cd%\bin\accountinfo\pass.txt
echo %date% > %cd%\bin\accountinfo\datecreated.txt
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set local_ip=%%a
set ip=%local_ip%  
goto :BREAK


:BREAK
echo %ip: =% >%cd%\bin\accountinfo\ip.txt
goto done

:accountdelete
if not exist %cd%\bin\accountinfo\user.txt goto errordel
cls
color 0c
title Account Deleter // @pfpz
echo Delete your account below!
set /p delete=Are you sure you want to delete your account? (Y or N): 
if %delete%==y goto deleted
if %delete%==n goto homesaklic

:deleted
cls
if exist %cd%\bin\accountinfo\user.txt goto delaccnow
if not exist %cd%\bin\accountinfo\user.txt goto errordel

:delaccnow
cls
del %cd%\bin\accountinfo\user.txt
del %cd%\bin\accountinfo\pass.txt
del %cd%\bin\accountinfo\datecreated.txt
del %cd%\bin\accountinfo\ip.txt
goto sucdel

:errordel
cls
color c0
title ERROR WHILE DELETING ACCOUNT: // @pfpz
msg * /TIME:5 "There is currently no accounts created on this device, Please try again",16, "Account Deletion Error:"
echo There was an issue with your deletion, please try again..
goto accountcreate

:sucdel
cls
color 0c
title Account Deleted Succesfully: // @pfpz
echo Deletion successful, return home now..
pause
goto homesaklic


:done
cls
color a0
title SAK Account Created Succesfully: // @pfpz
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Your account was successfully created. Press Yes to continue to SAK, No to go back to the account manager menu or Cancel to revert this process', 'SAK Account Created!: ', 'YesNoCancel', [System.Windows.Forms.MessageBoxIcon]::Information);}" > %TEMP%\out78.tmp
set /p buttonpress=<%TEMP%\out78.tmp
if %buttonpress%==Yes goto home
if %buttonpress%==No goto homesaklic
if %buttonpress%==Cancel (del %cd%\bin\accountinfo\user.txt
del %cd%\bin\accountinfo\pass.txt
del %cd%\bin\accountinfo\datecreated.txt
del %cd%\bin\accountinfo\ip.txt
goto accountcreate) 
goto homesaklic

:accinfo
cls
color 0c
title SAK Account Info // @pfpz
if exist %cd%\bin\accountinfo\pass.txt (
echo Account info is displayed below
echo Username: %userfile%
echo Password: %passfile%
echo Date created: %datefile%
echo IP Associated to account: %ipfile%
pause
goto homesaklic) else echo There is currently no account created on this device, create
echo an account now and try again
timeout /t 5
goto homesaklic
