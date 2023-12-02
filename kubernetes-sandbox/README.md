# Kubernetes Test Environment with Vagrant

Important to run all commands you must be in the directory

## Requirements

Use the `./initial-setup.sh`

If you choose not to install the requirements through a script, you must have the following installed:

- Vagrant
- vagrant-libvirt
- vagrant-mutate
- qemu libvirt-daemon-system
- libvirt-clients
- libxslt-dev
- libxml2-dev
- libvirt-dev
- zlib1g-dev
- ruby-dev
- ruby-libvirt
- ebtables
- dnsmasq-base
- k0sctl

## To Setup The Cluster

run `./deploy.sh`

## To Stop the Cluster temporary

run `vagrant halt`

## To Start the Cluster after a Stop

run `vagrant up`

## To Delete the Cluster

run `vagrant destroy`

## To Use k9s with the Config

run `k9s --kubeconfig kubeconfig.yaml`
