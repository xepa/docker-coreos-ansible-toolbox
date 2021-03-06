#!/usr/bin/env sh

set -euo pipefail

cd $(dirname $0)

# Update and install apk packages.
cat /etc/resolv.conf
ifconfig
ping -c 10 192.168.42.50 

#ping -c 1 dl-4.alpinelinux.org 
ip route show

echo 'Installing Python.'
apk --update add \
    py-crypto \
    python \
    tzdata \

FLEET_VERSION='0.11.5'

echo 'Installing fleetctl.'
apk add \
    curl

curl -LOks https://github.com/coreos/fleet/releases/download/v${FLEET_VERSION}/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
  tar zxvf fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
  cp fleet-v${FLEET_VERSION}-linux-amd64/fleetctl /usr/bin/fleetctl && \
  rm -rf fleet-v* && \
  chmod +x /usr/bin/fleetctl

# install 

# Install pip.

echo 'Installing pip.'
python /docker/get-pip.py

# Installing ansible.

echo 'Installing Ansible.'
pip install ansible

echo -n 'Cleaning up container…'

rm -rf \
    /docker \
    /var/cache/apk/*

echo ' OK!'
