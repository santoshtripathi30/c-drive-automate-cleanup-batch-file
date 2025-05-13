@echo off
setlocal

REM Set the username (this will automatically use the logged-in user)
set "USERNAME=%USERNAME%"

echo Deleting Chrome and Visual Studio cache and other data for user: %USERNAME%

REM Define Chrome user data path
set "CHROME_USER_DATA=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data"

REM Loop through all profiles for Chrome
for /d %%p in ("%CHROME_USER_DATA%\Profile*") do (
    echo Deleting Service Worker, Code Cache, and Cache for: %%p

    REM Delete Service Worker
    del /f /s /q "%%p\Service Worker\*"

    REM Delete Code Cache
    del /f /s /q "%%p\Code Cache\*"

    REM Delete Cache
    del /f /s /q "%%p\Cache\*"
)

REM Loop through all Visual Studio versions for JSProjSystem
for /d %%v in ("C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio\*") do (
    if exist "%%v\JSProjectSystem" (
        echo Deleting JSProjectSystem for: %%v
        del /f /s /q "%%v\JSProjectSystem\*"
    )
)

REM Loop through all Visual Studio versions for WebTools
for /d %%v in ("C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio\*") do (
    if exist "%%v\WebTools" (
        echo Deleting WebTools for: %%v
        del /f /s /q "%%v\WebTools\*"
    )
)

REM Additional cleanup (Windows, npm, etc.)
del /f /s /q "C:\Windows\SoftwareDistribution\Download\*"
del /f /s /q "C:\Windows\Minidump\*"
del /f /q "C:\Windows\MEMORY.DMP"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\AzureFunctionsTools\*"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\npm-cache\*"
del /f /s /q "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\*"

echo.
echo Cleanup complete.
pause
