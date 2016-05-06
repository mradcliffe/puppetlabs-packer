#!/bin/bash

echo "Changing SELinux to permissive..."
sudo cp /etc/sysconfig/selinux /etc/sysconfig/selinux.old
sudo sed -i 's#^SELINUX=disabled#SELINUX=permissive#' /etc/sysconfig/selinux
