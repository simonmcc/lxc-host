Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.network :private_network, ip: "192.168.50.23"

  config.vm.define :vbox do |vbox_config|
    vbox_config.vm.network :forwarded_port, guest: 3000, host: 3001
    vbox_config.vm.hostname = "lxc-host"

    vbox_config.vm.provision :shell, inline:
      # vagrant-lxc required dependencies and vagrant itself
      'sudo apt-get update && 
       sudo apt-get install -y redir lxc &&
      wget -q "http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_`uname -m`.deb" -O /tmp/vagrant.deb &&
      sudo dpkg -i /tmp/vagrant.deb &&
      vagrant plugin install vagrant-lxc &&
      vagrant box add precise64 http://bit.ly/vagrant-lxc-precise64-2013-07-12 --provider=lxc &&
      echo export VAGRANT_DEFAULT_PROVIDER=lxc | sudo tee /etc/profile.d/vagrant-lxc.sh'
  end

  config.vm.define :lxc do |lxc_config|
    lxc_config.vm.network :forwarded_port, guest: 80, host: 3000
    lxc_config.vm.provision :shell, inline:
      'echo "Replace this with your puppet manifests"'
  end
end
