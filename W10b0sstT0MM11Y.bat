@echo off
echo ========================================
echo ULTIMATE WINDOWS OPTIMIZATION SCRIPT
echo User: T0MM11Y
echo Date: 2025-06-08
echo ========================================
echo.
echo WARNING: This will PERMANENTLY disable Windows Updates!
echo Press any key to continue or Ctrl+C to cancel...
pause

@rem *** Disable Some Service ***
sc stop DiagTrack
sc stop diagnosticshub.standardcollector.service
sc stop dmwappushservice
sc stop WMPNetworkSvc
sc stop WSearch
sc stop Fax
sc stop BITS
sc stop wuauserv
sc stop UsoSvc
sc stop WaaSMedicSvc
sc stop DoSvc
sc stop Spooler
sc stop Themes
sc stop AudioSrv
sc stop AudioEndpointBuilder
sc stop TabletInputService
sc stop SysMain
sc stop Superfetch
sc stop PcaSvc
sc stop WerSvc
sc stop ErrorReportingService

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
sc config WMPNetworkSvc start= disabled
sc config WSearch start= disabled
sc config Fax start= disabled
sc config BITS start= disabled
sc config wuauserv start= disabled
sc config UsoSvc start= disabled
sc config WaaSMedicSvc start= disabled
sc config DoSvc start= disabled
sc config Spooler start= disabled
sc config Themes start= disabled
sc config AudioSrv start= disabled
sc config AudioEndpointBuilder start= disabled
sc config TabletInputService start= disabled
sc config SysMain start= disabled
sc config Superfetch start= disabled
sc config PcaSvc start= disabled
sc config WerSvc start= disabled
sc config ErrorReportingService start= disabled
sc config RemoteRegistry start= disabled
sc config TrkWks start= disabled

REM *** SCHEDULED TASKS tweaks ***
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable

@rem *** COMPLETELY DISABLE WINDOWS UPDATE FOREVER ***
echo Disabling Windows Update PERMANENTLY...

REM Stop and disable all Windows Update services
net stop wuauserv
net stop UsoSvc
net stop bits
net stop DoSvc
net stop WaaSMedicSvc

REM Take ownership and rename Windows Update folders
takeown /f "C:\Windows\System32\wuaueng.dll" /a
icacls "C:\Windows\System32\wuaueng.dll" /grant administrators:F
ren "C:\Windows\System32\wuaueng.dll" "wuaueng.dll.bak"

takeown /f "C:\Windows\System32\wuapi.dll" /a
icacls "C:\Windows\System32\wuapi.dll" /grant administrators:F
ren "C:\Windows\System32\wuapi.dll" "wuapi.dll.bak"

takeown /f "C:\Windows\System32\wups.dll" /a
icacls "C:\Windows\System32\wups.dll" /grant administrators:F
ren "C:\Windows\System32\wups.dll" "wups.dll.bak"

takeown /f "C:\Windows\System32\wups2.dll" /a
icacls "C:\Windows\System32\wups2.dll" /grant administrators:F
ren "C:\Windows\System32\wups2.dll" "wups2.dll.bak"

REM Rename Windows Update directories
takeown /f "C:\Windows\SoftwareDistribution" /r /d y
icacls "C:\Windows\SoftwareDistribution" /grant administrators:F /t
ren "C:\Windows\SoftwareDistribution" "SoftwareDistribution.bak"

takeown /f "C:\Windows\System32\catroot2" /r /d y
icacls "C:\Windows\System32\catroot2" /grant administrators:F /t
ren "C:\Windows\System32\catroot2" "catroot2.bak"

@rem *** Registry tweaks for Windows Update blocking ***
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d " " /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d " " /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateServiceUrlAlternate" /t REG_SZ /d " " /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f

@rem *** Block Windows Update URLs via HOSTS file ***
echo. >> %windir%\System32\drivers\etc\hosts
echo # Block Windows Update >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 windowsupdate.microsoft.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 update.microsoft.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 windowsupdate.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 download.microsoft.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 wustat.windows.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 ntservicepack.microsoft.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 go.microsoft.com >> %windir%\System32\drivers\etc\hosts
echo 0.0.0.0 download.windowsupdate.com >> %windir%\System32\drivers\etc\hosts

@rem *** Remove Telemetry & Data Collection ***
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f

@REM Settings -> Privacy -> General -> Let apps use my advertising ID...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
REM - SmartScreen Filter for Store Apps: Disable
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f
REM - Let websites provide locally...
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

@REM WiFi Sense: HotSpot Sharing: Disable
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f
@REM WiFi Sense: Shared HotSpot Auto-Connect: Disable
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f

@REM COMPLETE Windows Update Disable
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f
@REM Disable P2P Update downloads outside of local network
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f

@rem *** EXTREME PERFORMANCE TWEAKS ***
echo Applying extreme performance tweaks...

REM Disable Windows Search indexing
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d 4 /f

REM Disable Superfetch/Prefetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f

REM Disable Windows Defender (CAUTION!)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f

REM Disable hibernation and fast startup
powercfg -h off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f

REM Set performance power plan
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

REM Disable visual effects for maximum performance
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f

REM Disable system restore
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "DisableSR" /t REG_DWORD /d 1 /f

REM Disable Windows tips and suggestions
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f

REM *** Hide the search box from taskbar ***
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

REM *** Disable MRU lists (jump lists) of XAML apps in Start Menu ***
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

REM *** Set Windows Explorer to start on This PC instead of Quick Access ***
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

@rem Remove MORE Apps for better performance
echo Removing more bloatware apps...
PowerShell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *bing* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *people* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *photos* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *solit* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *zune* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Sway* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *CommsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Facebook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Twitter* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Drawboard PDF* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"

@rem Explorer optimizations
REM *** Show file extensions in Explorer ***
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f

REM *** Show hidden files in Explorer ***
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f

REM *** Show super hidden system files in Explorer ***
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f

REM *** Uninstall OneDrive ***
echo Removing OneDrive completely...
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
rd C:\OneDriveTemp /Q /S >NUL 2>&1
rd "%USERPROFILE%\OneDrive" /Q /S >NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1

echo.
echo ========================================
echo OPTIMIZATION COMPLETE!
echo ========================================
echo.
echo Changes made:
echo - Windows Update PERMANENTLY disabled
echo - All telemetry and tracking disabled  
echo - Bloatware apps removed
echo - Performance optimizations applied
echo - Visual effects disabled
echo - System restore disabled
echo - Windows Defender disabled (CAUTION!)
echo.
echo IMPORTANT: 
echo 1. Windows Update is now COMPLETELY blocked
echo 2. Security updates will NOT be installed
echo 3. This is PERMANENT and difficult to reverse
echo 4. Consider manual security software installation
echo.
echo Windows Explorer will restart now...
pause
start /wait TASKKILL /F /IM explorer.exe
start explorer.exe

echo.
echo System optimization completed!
echo Please restart your computer for all changes to take effect.
pause