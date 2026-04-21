@echo off
echo 🗑️ Clearing Liva Database...
echo.

REM Check if device is connected
adb devices | findstr "device$" >nul
if errorlevel 1 (
    echo ❌ No Android device connected or ADB not found
    echo Please connect your device and enable USB debugging
    pause
    exit /b 1
)

echo ✅ Android device detected
echo.

REM Clear the app's data (this will reset the entire app including database)
echo Clearing app data...
adb shell pm clear com.liva.liva

if errorlevel 0 (
    echo ✅ Successfully cleared Liva app data and database
    echo.
    echo The app has been reset to initial state:
    echo - All threat records removed
    echo - All user preferences reset
    echo - You will need to grant permissions again
) else (
    echo ❌ Failed to clear app data
    echo Make sure the Liva app is installed on your device
)

echo.
echo Press any key to exit...
pause >nul