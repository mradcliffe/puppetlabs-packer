# puppetlabs-packer

### About

This repository contains the [Packer](http://packer.io) and [Puppet](http://puppetlabs.com) manifests used to build boxes shipped to [Vagrant Cloud](http://vagrantcloud.com/puppetlabs).

### VM settings

* `root` password is set to `puppet`
* `vagrant` account uses the [Vagrant project's insecure public key](https://github.com/mitchellh/vagrant/tree/master/keys)

## SELinux box notes

* Requires the ovf from another build to be around. This is usually inside the templates/centos-7.2 directory.
* the template json may have some hard coded stuff.

### Issues

Please open any issues within the CPR ( Community Package Repository ) project on the [Puppet Labs issue tracker](https://tickets.puppetlabs.com/browse/CPR).
