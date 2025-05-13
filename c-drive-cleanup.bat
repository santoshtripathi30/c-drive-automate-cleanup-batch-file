
@echo off
setlocal

REM Set the username (this will automatically use the logged-in user)
set "USERNAME=%USERNAME%"

echo Deleting Chrome cache and other data for user: %USERNAME%

REM Define Chrome user data path
set "CHROME_USER_DATA=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data"

REM Loop through all profiles
for /d %%p in ("%CHROME_USER_DATA%\Profile*") do (
    echo Deleting Service Worker, Code Cache, and Cache for: %%p

    REM Delete Service Worker
    del /f /s /q "%%p\Service Worker\*"

    REM Delete Code Cache
    del /f /s /q "%%p\Code Cache\*"

    REM Delete Cache
    del /f /s /q "%%p\Cache\*"
)

REM Additional cleanup (Windows, Visual Studio, etc.)
del /f /s /q "C:\Windows\SoftwareDistribution\Download\*"
del /f /s /q "C:\Windows\Minidump\*"
del /f /q "C:\Windows\MEMORY.DMP"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio\17.0_039bfd05\JSProjectSystem\*"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio\17.0_039bfd05\WebTools\*"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\AzureFunctionsTools\*"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\npm-cache\*"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\*"

echo.
echo Cleanup complete.
pause
