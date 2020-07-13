#!/usr/bin/env sh
set -e

echo "Downloading the raspios zip"
filename=$(basename $(wget --no-clobber --content-disposition "https://downloads.raspberrypi.org/raspios_lite_armhf_latest" 2>&1 | grep "Location: " | cut -d' ' -f2 ))

echo "Extracting the image"
unzip -n $filename > /dev/null

echo "Setting up loopdevice"
mkdir -p temp
imagename="$(echo $filename | cut -f1 -d'.').img"
lodevice=$(losetup -f)
losetup -fP $imagename
mount "${lodevice}p2" temp
mount "${lodevice}p1" temp/boot

echo "Patching image to enable ssh"
touch temp/boot/ssh
mkdir -p temp/home/pi/.ssh
if [ -e keys/*.pub ]; then
    echo "Adding provided keys to the image"
    for key in keys/*.pub; do cat $key >> temp/home/pi/.ssh/authorized_keys; done
else
    echo "No keys were given"
fi

echo "Cleaning up"
umount temp/boot
umount temp
rmdir temp
losetup -d $lodevice
