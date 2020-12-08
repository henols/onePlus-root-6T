#!/bin/bash

# See https://forum.xda-developers.com/oneplus-6t/development/recovery-unofficial-twrp-touch-recovery-t3861482

# twrp='twrp-3.3.1-20-fajita-Q-mauronofrio'
twrp_version='3.4.0-2-fajita'
twrp='twrp-'$twrp_version'.img'
twrp_installer='twrp-installer-'$twrp_version'.zip'

magisk="Magisk-v21.1"

sideload_twrp=1

echo "Installing TWRP version:" $twrp_version
echo "Installing Magisk version:" $magisk
echo
echo "TWRP https://dl.twrp.me/fajita/"
echo "Magisk https://magiskmanager.com/"

read -p "Press enter to continue"
sudo adb devices
echo "Reboot into fasboot"
adb reboot bootloader
echo "Pushing boot image "$twrp
sudo fastboot boot $twrp
echo "When booted in to twrp lock screen"
if [ "$sideload_twrp" -eq "1" ]; then
  echo "Go to Advanced, enable ADB sideload"
  read -p "Press enter to continue"
  sudo adb sideload $twrp_installer
  echo -p "Go back and enable ADB sideload"
else
  sudo adb push $twrp" /sdcard/"$twrp
  echo "Go to Advanced, Install Recovery Ramdisk, select /sdcard/"$twrp
  read -p "Press enter to continue"
  echo "Go to Advanced, enable ADB sideload"
fi
read -p "Press enter to continue"
sudo adb sideload $magisk".zip"
echo "Reboot into your device’s system and you’re done!"

