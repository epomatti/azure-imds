#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

# Update
apt update
apt upgrade -y

apt-get install jq -y


reboot
