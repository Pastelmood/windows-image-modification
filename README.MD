# Windows Image Modification
Demo modifying Windows 11 Enterprise with an active local administrator and setting a default password.

### Prerequisite
* [AnyBurn](https://www.anyburn.com/)
* [Media Creation Tool](https://www.microsoft.com/software-download/windows11)
* Windows Terminal with Administrator (Command Prompt or Powershell)

### Create Wroking Folders
Run the Create-Folders.bat to creates below:
* "C:\Win11Custom"
* "C:\Win11ESD"
* "C:\Win11Original"
* "C:\Win11WIM"
* "C:\Win11ISO"
* "C:\Win11Mount"

### Download Windows 11 Enterprise
Run the command below in Windows Terminal (assuming that the Media Creation Tool is in the directory C:\Win11Original).
```bash
MediaCreationTool_Win11_23H2.exe /Eula Accept /Retail /MediaArch x64 /MediaLangCode en-US /MediaEdition Enterprise
```
##### Default Active Key
```
NPPR9-FWDCX-D2C8J-H872K-2YT43
```

### Mount the Windows 11 ISO
1. Right-click the ISO file and select "Mount".
2. Note the drive letter assigned to the mounted ISO.

### Copy the ISO Contents to a Local Folder
Copy all the contents of the mounted ISO to this folder.

Or run below command in Windows Terminal (assuming the mount drive letter is D:):
```bat
robocopy D:\ C:\Win11ISO /mir
```

### Check Windows edition index
```bat
dism /Get-WimInfo /WimFile:C:\Win11ISO\sources\install.esd
```