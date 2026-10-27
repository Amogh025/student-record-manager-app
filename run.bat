@echo off
setlocal
cd /d "%~dp0"
set "DRIVER_VERSION=9.3.0"
set "DRIVER_JAR=lib\mysql-connector-j-%DRIVER_VERSION%.jar"
if not exist lib mkdir lib
if not exist "%DRIVER_JAR%" (
  echo Downloading MySQL Connector/J %DRIVER_VERSION%...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/%DRIVER_VERSION%/mysql-connector-j-%DRIVER_VERSION%.jar' -OutFile '%DRIVER_JAR%'"
  if errorlevel 1 (echo Driver download failed. Check internet access. & exit /b 1)
)
if not exist out mkdir out
where javac >nul 2>nul
if errorlevel 1 (echo JDK 17 or newer is required. Install a JDK and add it to PATH. & exit /b 1)
echo Compiling application...
javac -encoding UTF-8 -cp "%DRIVER_JAR%" -d out src\main\java\StudentRecordApp.java
if errorlevel 1 exit /b 1
if not defined DB_USER set "DB_USER=root"
echo Starting Student Record Manager...
if defined DB_PASSWORD (
  java -cp "out;%DRIVER_JAR%" StudentRecordApp
) else (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$secure = Read-Host 'MySQL password (input hidden)' -AsSecureString; $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure); try { $env:DB_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer); & java -cp 'out;%DRIVER_JAR%' StudentRecordApp; exit $LASTEXITCODE } finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer) }"
)
