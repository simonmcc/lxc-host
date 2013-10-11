Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.network :public_network

  ## For masterless, mount your salt file root
  config.vm.synced_folder ".", "/srv/salt/"
  config.vm.synced_folder "vagrant/pillar", "/srv/pillar/"

  # make this where your "work" is
  config.vm.synced_folder File.join(ENV['HOME'], 'src'), "/work/"

  config.vm.define :lxc_host do |vbox_config|
    vbox_config.vm.hostname = "lxc-host"
  end

  ## Use all the defaults:
  config.vm.provision :salt do |salt|
    salt.verbose = true

    salt.minion_config = "vagrant/minion"
    salt.run_highstate = true
  end

end
