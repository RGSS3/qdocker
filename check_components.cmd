@echo off
if not exist boot2docker.iso (
  powershell -c "[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;Invoke-WebRequest -uri https://github.com/boot2docker/boot2docker/releases/download/v18.09.5/boot2docker.iso -OutFile boot2docker.iso"
)