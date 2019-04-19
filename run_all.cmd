@echo off
call check_components.cmd
set QEMU=%~dp0qemu.2019.2\
set QEMU.EXE=%QEMU%qemu-system-x86_64.exe
set QEMU-IMG.EXE=%QEMU%qemu-img.exe
set DOCKER.ISO=%~dp0boot2docker.iso
set HDA=%~dp0hda.raw
if "%QDOCKER.USEDISK%" == "1" set QDOCKER.HDA=-drive format=raw,file=%HDA%
if not "%QDOCKER.USEDISK%" == "1" (
  set QDOCKER.HDA=
  if not exist %HDA% (
    call :create-disk
    exit /b
  )
)
echo %*
call :run-qemu %*
exit /b

:run-qemu
echo %QEMU.EXE% -net nic -net user,hostfwd=tcp::5022-:22 -cdrom %DOCKER.ISO%  -boot d %* %QDOCKER.HDA%
%QEMU.EXE% -net nic -net user,hostfwd=tcp::5022-:22 -cdrom %DOCKER.ISO%  -boot d %* %QDOCKER.HDA%
exit /b
:create-disk
%QEMU-IMG.EXE% create -f raw %HDA% 8G 
call :run-qemu
exit /b

REM -kernel bzImage -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw console=tty0"

