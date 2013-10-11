#
# salt state to configure a host to run lxc containers
#

#
#     vagrant plugin install vagrant-lxc &&
#     vagrant box add precise64 http://bit.ly/vagrant-lxc-precise64-2013-07-12 --provider=lxc &&

requirements:
  pkg.installed:
    - pkgs:
      - vim
      - tmux
      - htop
      - denyhosts
      - build-essential
      - lxc
      - redir
      - openssh-server
      - curl

# set UseDNS=no in /etc/ssh/sshd_config to speed up connections
/etc/ssh/sshd_config:
  file:
    - managed
    - source: salt://lxc-host/templates/sshd_config.jinja
    - template: jinja
    - require:
      - pkg: openssh-server

/etc/network/interfaces:
  file:
    - managed
    - source: salt://lxc-host/templates/interfaces.jinja
    - template: jinja

avahi-daemon:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/avahi/services/ssh.service

/etc/avahi/services/ssh.service:
  file:
    - managed
    - source: salt://lxc-host/files/ssh.service

ufw:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/default/ufw

/etc/default/ufw:
  file:
    - managed
    - source: salt://lxc-host/files/ufw

/etc/sudoers:
  file:
    - managed
    - mode: 0440
    - user: root
    - group: root
    - source: salt://lxc-host/files/sudoers

#
# Vagrant install on the lxc-host
vagrant:
  pkg.installed:
    - sources:
      - vagrant: http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_x86_64.deb
    - require:
      - pkg: requirements

# install the vagrant-lxc plugin, if required (as the vagrant user)
vagrant plugin install vagrant-lxc:
  cmd:
    - run
    - user: vagrant
    - unless: vagrant plugin list | grep vagrant-lxc
    - require:
      - pkg: vagrant


# install the vagrant-hostmanager plugin, if required (as the vagrant user)
vagrant plugin install vagrant-hostmanager:
  cmd:
    - run
    - user: vagrant
    - unless: vagrant plugin list | grep vagrant-hostmanager
    - require:
      - pkg: vagrant

# and seen as we're a salt shop now:
vagrant plugin install vagrant-salt:
  cmd:
    - run
    - user: vagrant
    - unless: vagrant plugin list | grep vagrant-salt
    - require:
      - pkg: vagrant

# install a precise64 lxc box
vagrant box add precise64 http://dl.dropbox.com/u/13510779/lxc-precise-amd64-2013-07-12.box
  cmd:
    - run
    - user: vagrant
    - unless: vagrant box list | grep precise64 | grep lxc
    - require:
      - pkg: vagrant

# use lxc by default on the lxc-host
#     echo export VAGRANT_DEFAULT_PROVIDER=lxc | sudo tee /etc/profile.d/vagrant-lxc.sh'#
/etc/profile.d/vagrant-lxc.sh:
  file:
    - managed
    - contents: "export VAGRANT_DEFAULT_PROVIDER=lxc\n"
