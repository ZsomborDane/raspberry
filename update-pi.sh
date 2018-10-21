#!/bin/bash
set -e

# Raspberry Pi update script
# Zsombor Dane

# 
# Usage: 
# $ sudo ./update-pi
#
# Run from Cron & GitHub:
# $ curl -s https://raw.githubusercontent.com/ZsomborDane/raspberry/master/update-pi | sudo bash


# Must be run as root or sudo
if [ $(id -u) != 0 ]
then
  echo "This script must be run as root or with sudo."
  exit
fi

echo "Installing automatic updates..."

if crontab -l | grep -q "sudo apt -y update"; 
then 
  echo "Auto update of package list already exists in crontab"
else
  echo "Adding auto update of package list to crontab"
  (crontab -l || true; echo "0 3 * * * sudo apt -y update") | crontab - 
fi

if crontab -l | grep -q "sudo apt -y dist-upgrade"; 
then 
  echo "Upgrade of installed packages already exists in crontab"
else
  echo "Adding upgrade of installed packages"
  (crontab -l || true; echo "0 4 * * * sudo apt -y dist-upgrade") | crontab - 
fi

crontab -l

echo "Installation complete. Enjoy!"
