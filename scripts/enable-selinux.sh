#!/bin/bash

echo "Installing SELinux minimum policy..."
sudo yum makecache
sudo yum install -y -q selinux-policy-minimum selinux-policy-targeted

echo "Changing SELinux to permissive..."
sudo sed -i 's#^SELINUX=disabled#SELINUX=permissive#' /etc/selinux/config

echo "Rebooting..."
reboot
