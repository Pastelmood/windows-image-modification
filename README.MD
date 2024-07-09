# Windows Image Modification
Demo modifying Windows 11 Enterprise with an active local administrator and setting a default password.

### Prerequisite
* [AnyBurn](https://www.anyburn.com/)
* [Media Creation Tool](https://www.microsoft.com/software-download/windows11)
* Windows Terminal with Administrator (Command Prompt or Powershell)

### Step 1: Create Working Folders
Run the Create-Folders.bat to creates below:
* "C:\Win11Custom"
* "C:\Win11ESD"
* "C:\Win11Original"
* "C:\Win11WIM"
* "C:\Win11ISO"
* "C:\Win11Mount"

### Step 2: Download Windows 11 Enterprise
Run the command below in Windows Terminal (assuming that the Media Creation Tool is in the directory C:\Win11Original).
```shell
MediaCreationTool_Win11_23H2.exe /Eula Accept /Retail /MediaArch x64 /MediaLangCode en-US /MediaEdition Enterprise
```
##### Default Active Key
```
NPPR9-FWDCX-D2C8J-H872K-2YT43
```

### Step 3: Mount the Windows 11 ISO
1. Right-click the ISO file and select "Mount".
2. Note the drive letter assigned to the mounted ISO.

### Step 4: Copy the ISO Contents to a Local Folder
Copy all the contents of the mounted ISO to this folder.

Or run below command in Windows Terminal (assuming the mount drive letter is D:):
```shell
robocopy D:\ C:\Win11ISO /mir
```

### Step 5: Check Windows Edition Index
```shell
dism /Get-WimInfo /WimFile:C:\Win11ISO\sources\install.esd
```
In the picture below, Windows 11 Enterprise is index 3. Remember, we will use the index number in the next step.
![Windows Edition Index](https://github.com/Pastelmood/windows-image-modification/blob/main/img/image_001.jpg "Windows Edition Index")

### Step 6: Convert install.esd to install.wim
```shell
dism /Export-Image /SourceImageFile:C:\Win11ISO\sources\install.esd /SourceIndex:3 /DestinationImageFile:C:\Win11WIM\install.wim /Compress:max /CheckIntegrity
```

### Step 7: Mount the Windows Image
```shell
dism /Mount-Wim /WimFile:C:\Win11WIM\install.wim /Index:1 /MountDir:C:\Win11Mount
```

### Step 8: Add Setup Complete Script
1. Edit local administrator password from `SetupComplete.cmd`
2. Copy the file `SetupComplete.cmd` from this repository to `C:\Win11Mount\Windows\Setup\Scripts.`
```
REM SetupComplete.cmd
@echo off

REM Activate the administrator account and set a password
net user administrator choose_your_password /active:yes

REM Set the administrator account's password to never expire
wmic useraccount where "Name='administrator'" set PasswordExpires=false

REM Delete the script itself
del "%~f0"
```

### Step 9: Unmount and Commit Changes
```shell
dism /Unmount-Wim /MountDir:C:\Win11Mount /Commit
```

### Step 10: Replace the Original install.esd with the Modified install.wim
1. Open AnyBurn
2. Click on `Edit image file` button
3. Select original Windows 11 ISO file from `C:\Win11Original`
4. Remove `install.esd` from `sources` folder
5. Add modify `install.wim` from `C:\Win11WIM`
6. Create new Windows 11 ISO file and save in `C:\Win11Custom`

---

### Optional: Optimize and Compress the WIM File
```shell
dism /Export-Image /SourceImageFile:C:\Win11WIM\install.wim /SourceIndex:1 /DestinationImageFile:C:\Win11WIM\install_compressed.wim /Compress:max /CheckIntegrity
```

### Convert Back to ESD
```shell
dism /Export-Image /SourceImageFile:C:\Win11WIM\install_compressed.wim /SourceIndex:1 /DestinationImageFile:C:\Win11ISO\sources\install.esd /Compress:recovery /CheckIntegrity
```