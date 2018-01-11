# puppetlabs-packer

### About

This repository contains the [Packer](http://packer.io) and [Puppet](http://puppetlabs.com) manifests used to build boxes shipped to VMware vsphere.

The Packer templates are organized under the following directory structure inside the root `templates` directory:
```
<os-family>/<os-distribution>/<os-variant>/<architecture>
```

1. `<os-family>` is the OS family, i.e. `linux`, `windows`, `macos`, `solaris`
1. `<os-distribution>` is the distribution, and is only used among linux templates, e.g. `redhat` or `ubuntu`
1. `<os-variant>` is the version or variant, e.g. `7` for redhat, `10.13` for macOS, or '11.2' for solaris
1. `<architecture>` is the architecture, e.g. `x86_64` or `i386`

The `architecture` directory can contain (1) and (2), and technically (3), but we do not recommend (3) (as it’s highly likely that scripts, patches, or pressed files can apply to multiple architectures of a specific OS variant so they might as well be in their own `common` directory). There is one caveat. If a `common` or `architecture` directory contains a particular template (e.g. like vmware.base.json) AND a `vars.json` file, then all variables for the template should be declared both in the template itself, and in any `vars.json` files found in sub-directories — the `vars.json` file in the current directory should not have variables for that specific template.

Each directory (excluding the `architecture` directory) may or may not have a `common` directory in it. This directory can contain the following files:

* A specialized template that is specific to any sub-directories under that section.
* A `vars.json` file containing the required variables needed for other, parent `common` templates to build successfully.
* Other files, such as scripts, patches, or preseed files.

The intent for the `common` directory is to contain things that may be shared by some of the sub-directories. Here are all of the possible locations that a `common` directory could appear and their meaning:

* `<os-family>/<common>` represents templates and files that are shared by some OS distributions. For example, we have base templates in linux/common that are shared by Centos, Ubuntu, Fedora, Oracle Linux, and Scientific Linux.
* `<os-family>/<os-distribution>/<common>` represents templates, variables and files that are shared by variants of a single OS distribution. For example for our Centos platforms, we have a `vars.json` file in `linux/centos/common` that captures a common boot command.
* `<os-family>/<os-distriubtion>/<variant>/<common>` represents templates, variables, and files specific to architectures of a variant of an OS distribution. For example for our Centos platforms, we have our pressed files in `linux/centos/<variant>/common`, as well as some overriding variables for Centos 5.11 and Centos 6.6.

Currently, all of our Linux and macOS platforms adopt this directory structure. The Windows platforms will be reworked soon to fit it as well.

### SSH user accounts

* Linux: the root password is `puppet`
* Windows: the Administrator password is `PackerAdmin`
* Solaris: the root password is `root`
* macOS: see the README under templates/macos

## Documentation

Confluence Documentation is available for the [Windows/Packer Imaging Process](https://confluence.puppetlabs.com/display/SRE/Packer+Generation+of+Windows+Templates+for+VMPooler) and the [Linux/Packer Imaging Process](https://confluence.puppetlabs.com/display/SRE/Linux+Image+Packer+Generation).

## Tests

Some very basic linting has been added to ensure files parse properly through packer. To run these tests do:

  `make test`

### Issues

Please open any issues within the CPR ( Community Package Repository ) project on the [Puppet Labs issue tracker](https://tickets.puppetlabs.com/browse/CPR).

## Notes

This repository is currently undergoing a massive cleanup effort. We have decided to keep only the `vmware.base` and `vmware.vsphere.nocm` templates. If it turns out that this cleanup and refactoring has removed a template that you rely on (e.g. a virtual box or vagrant one), please checkout a version of the puppetlabs-packer repository at SHA `9babc323c862290d2eeb51d52fe133e564eba533` and accept our apologies in advance. We can correct these issues if we’re notified of them in a ticket.
