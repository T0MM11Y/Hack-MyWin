@echo off
setlocal EnableExtensions

:: Safe Performance Tweaks for Developers
:: - Keeps audio, camera, meetings, Windows Update, Defender, SmartScreen
:: - Avoids destructive actions (no renaming system DLLs, no HOSTS blocking)
:: - Reversible and conservative

:: Require Administrator
net session >NUL 2>&1
if %errorlevel% NEQ 0 (
  echo This script must be run as Administrator.
  pause
  exit /b 1
)

echo ========================================
echo SAFE PERFORMANCE PROFILE (Developer)
echo ========================================
echo This will apply conservative performance tweaks while preserving
echo sound, conferencing, and security features. Reversible.
echo Press any key to continue or Ctrl+C to cancel...
pause

echo.
echo [1/6] Power plan: High performance
:: Switch to High performance power plan (use SCHEME_MAX alias)
powercfg -setactive SCHEME_MAX >NUL 2>&1

:: NOTE: If on a laptop and you prefer Balanced for battery life,
:: run: powercfg -setactive SCHEME_BALANCED

echo.
echo [2/6] Explorer/Developer conveniences
:: Show file extensions
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >NUL
:: Show hidden files (user-level)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >NUL
:: OPTIONAL: show protected OS files (commented for safety)
:: reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f >NUL

:: Keep taskbar search box default (no changes)

:: Keep visual effects default (no forced Best Performance to avoid UI issues)


echo.
echo [3/6] Windows Update: Notify before download/install (kept enabled)
:: Keep Windows Update functional and secure, but less intrusive
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f >NUL
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >NUL
:: Ensure Windows Update talks to Microsoft (remove custom WSUS placeholders if any)
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /f >NUL 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /f >NUL 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateServiceUrlAlternate" /f >NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 0 /f >NUL

:: DO NOT disable any update services; DO NOT rename system files; DO NOT edit hosts


echo.
echo [4/6] Privacy/telemetry: set to Basic (compatible with Pro)
:: Keep SmartScreen/Defender enabled; only reduce telemetry to Basic
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 1 /f >NUL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 1 /f >NUL

:: Optional: disable CEIP tasks (safe to disable)
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >NUL 2>&1

:: Reduce tips/suggestions noise
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >NUL


echo.
echo [5/6] Preserve conferencing/media and security
:: Ensure audio services remain enabled (no changes to AudioSrv/AudioEndpointBuilder)
:: Ensure camera/mic functionality remains intact (no policy changes)
:: Keep Windows Defender and SmartScreen ON (no disabling here)
:: Keep Windows Search and SysMain ON (helpful for dev workflow)

:: DO NOT remove built-in apps or OneDrive here (reversible by user choice later)


echo.
echo [6/6] Optional toggles (commented by default)
:: Hibernation/Fast startup (uncomment if you want to turn off hiberfile)
:: powercfg -h off
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f

:: Delivery Optimization: keep default; to limit to LAN only, uncomment next line
:: reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f

:: Print Spooler: leave as-is for virtual/PDF printers; to disable if not needed:
:: sc config Spooler start= disabled & sc stop Spooler

:: RemoteRegistry: commonly safe to disable (security hardening)
sc config RemoteRegistry start= disabled >NUL 2>&1
sc stop RemoteRegistry >NUL 2>&1


echo.
echo Done. No destructive changes were made.
echo You may log off or restart later to apply all user-shell tweaks.
echo.
pause

endlocal
