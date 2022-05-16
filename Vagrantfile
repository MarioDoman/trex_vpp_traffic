# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "bento/ubuntu-18.04"

Vagrant.configure("2") do |config|
  config.vm.define "net2s22c05" do |subconfig|
    subconfig.vm.box = "bento/ubuntu-20.04"
    subconfig.vm.hostname = "net2s22c05"
    subconfig.vm.network :private_network, ip: "10.10.2.2", virtualbox__intnet: "intnet"
    subconfig.vm.network :private_network, ip: "10.10.1.2", virtualbox__intnet: "intnet"
    subconfig.vm.provision "file", source: "trex_cfg.yaml", destination: "trex_cfg.yaml"
    subconfig.vm.provision "shell", path: "script_trex.sh", run: 'always'
    subconfig.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 4
    end
  end

  config.vm.define "csp2s22c03" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "csp2s22c03"
    subconfig.vm.network :private_network, ip: "10.10.1.1", virtualbox__intnet: "intnet"
    subconfig.vm.network :private_network, ip: "10.10.2.1", virtualbox__intnet: "intnet"
    subconfig.vm.provision "shell", path: "script_vpp.sh", run: 'always'    
  end
  # config.vm.define "csp2s22c03" do |subconfig|
  #   subconfig.vm.box = BOX_IMAGE
  #   subconfig.vm.hostname = "csp2s22c03"
  #   subconfig.vm.network :private_network, ip: "10.10.1.1"
  #   subconfig.vm.network :private_network, ip: "10.10.2.1"
  #   subconfig.vm.provision "shell", inline:  <<-SCRIPT
  #     echo "deb \[trusted=yes\] https:\/\/packagecloud.io\/fdio\/release\/ubuntu bionic main" \| sudo tee "/etc/apt/sources.list.d/99fd.io.list"
  #     sudo curl -L https://packagecloud.io/fdio/release/gpgkey | sudo apt-key add -
  #     sudo apt-get update
  #     sudo apt-get --yes install vpp vpp-plugin-core vpp-plugin-dpdk
  #     sudo ifconfig eth1 down
  #     sudo ifconfig eth2 down
  #     sudo sed -i 's/# dpdk/dpdk/' /etc/vpp/startup.conf
  #     sudo sed -i 's/# dev 0000:02:00.0/dev 0000:00:08.0/' /etc/vpp/startup.conf
  #     sudo sed -i '/dev 0000:00:08.0/a \        dev 0000:00:09.0' /etc/vpp/startup.conf 
  #     sudo service vpp restart
  #     sleep 10
  #     sudo vppctl set int ip address GigabitEthernet0/8/0 10.10.1.1/24
  #     sudo vppctl set interface state GigabitEthernet0/8/0 up
  #     sudo vppctl set int ip address GigabitEthernet0/9/0 10.10.2.1/24
  #     sudo vppctl set interface state GigabitEthernet0/9/0 up
  #     SCRIPT
  # end

  
end
