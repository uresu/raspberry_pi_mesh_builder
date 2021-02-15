#!/bin/bash

#Burn basic PI OS image to an SD card, stick it in and assume it's /dev/sda
#Check manually and don't waste time making a script to do this - focus on the objective

sudo umount /mnt/pi-root
sudo umount /mnt/pi-boot

sudo mkdir -p /mnt/pi-boot
sudo mkdir -p /mnt/pi-root

sudo mount /dev/sda1 /mnt/pi-boot
sudo mount /dev/sda2 /mnt/pi-root

cd /mnt/pi-root/etc/wpa_supplicant

sudo rm wpa_supplicant.conf
sudo wget https://raw.githubusercontent.com/uresu/raspberry_pi_mesh_builder/main/wpa_supplicant.conf

sudo rm -rf /mnt/pi-root/root/pi_blink_ip
sudo git clone https://github.com/uresu/pi_blink_ip.git /mnt/pi-root/root/pi_blink_ip
echo '@reboot root /root/pi_blink_ip/blink_ip.py' | sudo tee -a /mnt/pi-root/etc/crontab

sudo touch /mnt/pi-boot/ssh

cd

sudo umount /mnt/pi-root
sudo umount /mnt/pi-boot


#Boot the pi and ssh in
