#!/bin/bash
set -ex

if [ $EUID != 0 ]; then
    echo "Please run as root"
    exit
fi

vagrant up
env SSH_KNOWN_HOSTS=/dev/null k0sctl apply -c k0sctl.yaml
ssh 192.168.7.2 -i priv_key -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" 'k0s kubeconfig admin > /root/.kube/config'
ssh 192.168.7.2 -i priv_key -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
ssh 192.168.7.2 -i priv_key -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" 'curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"'
ssh 192.168.7.2 -i priv_key -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" 'echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check'
ssh 192.168.7.2 -i priv_key -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" 'sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl'

scp -i priv_key -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" 192.168.7.2:/root/.kube/config kubeconfig.yaml