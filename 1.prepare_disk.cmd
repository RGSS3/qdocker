@echo off
call ssh "mkfs.ext4 -L boot2docker-data /dev/sda"
call ssh "sudo reboot"
