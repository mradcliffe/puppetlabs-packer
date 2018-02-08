#!/bin/bash

# Ensure that vagrant group is present
if [[ `grep -v -q "^vagrant" /etc/group` ]]; then
    echo "Adding vagrant group..."
    groupadd vagrant
fi

# Ensure that vagrant user is present
if [[ `id -u vagrant >/dev/null 2>&1` ]]; then
    # Modify the existing user.
    echo "Found vagrant user. Setting group to vagrant..."
    usermod -g vagrant -s /bin/bash
else
    # Create a new user.
    echo "Creating vagrant user..."
    useradd -g vagrant -s /bin/bash
fi

# Ensure that the vagrant user ssh directory exists.
mkdir -p /home/vagrant/.ssh

# Ensure that the vagrant user SSH directory has the correct permissions
chmod 0700 /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh

# Add authorized key file to SSH directory.
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys

# Add vagrant to sudoers
echo 'vagrant	ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
