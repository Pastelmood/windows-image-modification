# Windows Image Modification
Demo modifying Windows 11 Enterprise with an active local administrator and setting a default password.

### Prerequisite
* [AnyBurn](https://www.anyburn.com/)
* [Media Creation Tool](https://www.microsoft.com/software-download/windows11)

### Download Windows 11 Enterprise
Run the command below in Command Prompt (assuming that the Media Creation Tool is in the directory C:\Win11Original).
```bash
MediaCreationTool_Win11_23H2.exe /Eula Accept /Retail /MediaArch x64 /MediaLangCode en-US /MediaEdition Enterprise
```
