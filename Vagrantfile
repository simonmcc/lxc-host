Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  # config.vm.network :public_network

  # make the users home directory available as /work in the VM
  config.vm.synced_folder ENV['HOME'], "/work/"

  # give the VM an obvious name
  config.vm.define :lxc_host do |vbox_config|
    vbox_config.vm.hostname = "lxc-host"
  end

  # Use salt to provision the bare box to an LXC host
  config.vm.synced_folder ".", "/srv/salt/"
  config.vm.synced_folder "vagrant/pillar", "/srv/pillar/"

  config.vm.provision :salt do |salt|
    salt.verbose = true

    salt.minion_config = "vagrant/minion"
    salt.run_highstate = true
  end

end
