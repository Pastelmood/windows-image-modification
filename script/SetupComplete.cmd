@echo off

REM Activate the administrator account and set a password
net user administrator 1Duvel4you /active:yes

REM Set the administrator account's password to never expire
wmic useraccount where "Name='administrator'" set PasswordExpires=false

REM Delete the script itself
del "%~f0"
