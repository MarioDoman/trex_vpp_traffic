#!/bin/bash

sudo apt-get update
sudo apt-get -y install build-essential diffutils dpdk-igb-uio-dkms findutils g++ gcc git gzip htop ifupdown libdumbnet1 libelf-dev make mlocate python3-distutils sysvinit-utils unzip zlib1g-dev
wget --no-cache https://trex-tgn.cisco.com/trex/release/latest --no-check-certificate
tar -xzvf latest
sudo apt install -y linux-headers-`uname -r` build-essential
sudo cp trex_cfg.yaml /etc/trex_cfg.yaml


# sudo ./t-rex-64 -f cap2/dns.yaml -c 1 -m 1 -d 10


