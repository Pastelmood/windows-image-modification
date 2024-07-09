@echo off

REM Activate the administrator account and set a password
net user administrator choose_your_password /active:yes

REM Set the administrator account's password to never expire
wmic useraccount where "Name='administrator'" set PasswordExpires=false

REM Delete the script itself
del "%~f0"
