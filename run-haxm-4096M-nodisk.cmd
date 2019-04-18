@echo off
set QEMU=%~dp0qemu.2019.2\
set QEMU.EXE=%QEMU%qemu-system-x86_64.exe
set QEMU-IMG.EXE=%QEMU%qemu-img.exe
set DOCKER.ISO=%~dp0boot2docker.iso
set HDA=%~dp0hda.raw
call :run-qemu
exit /b

:run-qemu
%QEMU.EXE% -accel accel=hax -net nic -net user,hostfwd=tcp::5022-:22 -cdrom %DOCKER.ISO% -m 4096M -boot d %*
exit /b
:create-disk
call :run-qemu
exit /b

REM -kernel bzImage -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw console=tty0"