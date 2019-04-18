@echo off
if not exist boot2docker.iso (
  echo Fetching image
  call :download https://github.com/boot2docker/boot2docker/releases/download/v18.09.5/boot2docker.iso boot2docker.iso
)
if not exist "qemu.2019.2\qemu-system-x86_64.exe" (
  echo Fetching simulator
  call :download https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe qemu-setup.exe
  echo Unzipping simulator
  call qemu-setup /S /D=%~dp0qemu.2019.2
  del qemu-setup.exe
)

if not exist "putty\putty.exe" (
  echo Fetching SSH tool
  call :download https://the.earth.li/~sgtatham/putty/0.71/w64/putty.zip putty.zip
  echo Unzipping SSH tool
  call :unzip putty.zip putty
)

exit /b

:download 
powershell -c "[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;Invoke-WebRequest -uri %1 -OutFile %2"
exit /b

:unzip
powershell -c "Expand-Archive -DestinationPath %2 %1"
exit /b
