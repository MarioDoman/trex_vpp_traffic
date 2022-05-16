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
end
