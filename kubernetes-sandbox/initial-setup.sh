#!/bin/bash

# check sudo/root
if [ $EUID != 0 ]; then
    echo "Please run as root"
    exit
fi

# install requirements
sudo dnf update & dnf install @virtualization vagrant-libvirt libvirt-devel -y
sudo systemctl enable --now libvirtd

# install vagrant
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install vagrant

# install vagrant plugins
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-mutate

# set default provider
export VAGRANT_DEFAULT_PROVIDER=libvirt
