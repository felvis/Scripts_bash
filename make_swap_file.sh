#!/bin/bash
#Compatble with Ubuntu server
# Reference - https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-16-04
 
#Create swap file and enable it
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

#Add swap file to fstab
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
