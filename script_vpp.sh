#!/bin/bash

echo "deb [trusted=yes] https://packagecloud.io/fdio/release/ubuntu bionic main" | sudo tee "/etc/apt/sources.list.d/99fd.io.list"
sudo curl -L https://packagecloud.io/fdio/release/gpgkey | sudo apt-key add -
sudo apt-get update

#sudo apt-get -y install libvppinfra
#sudo apt-get -y install libvppinfra-dev
#sudo apt-get -y install python3-vpp-api
sudo apt-get -y install vpp
#sudo apt-get -y install vpp-dbg
#sudo apt-get -y install vpp-dev
sudo apt-get -y install vpp-plugin-core
#sudo apt-get -y install vpp-plugin-devtools
sudo apt-get -y install vpp-plugin-dpdk

sudo ifconfig eth1 down
sudo ifconfig eth2 down
sudo sed -i 's/# dpdk/dpdk/' /etc/vpp/startup.conf
sudo sed -i 's/# dev 0000:02:00.0/dev 0000:00:08.0/' /etc/vpp/startup.conf
sudo sed -i '/dev 0000:00:08.0/a \        dev 0000:00:09.0' /etc/vpp/startup.conf
sudo service vpp restart
sleep 10
sudo vppctl set int ip address GigabitEthernet0/8/0 10.10.1.1/24 
sudo vppctl set interface state GigabitEthernet0/8/0 up
sudo vppctl set int ip address GigabitEthernet0/9/0 10.10.2.1/24
sudo vppctl set interface state GigabitEthernet0/9/0 up
sudo vppctl ip route add 16.0.0.0/8 via 10.10.1.2
sudo vppctl ip route add 48.0.0.0/8 via 10.10.2.2