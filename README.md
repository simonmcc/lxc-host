lxc-host
========

Build an lxc-host to contain a bunch of lxc things, probably more Vagrant based boxes.  Primarily to be used in on Mac OSX or on paranoid people who run everything in a VM.

This is really just an automated setup base on [Rui Carmo](http://taoofmac.com/space/people/Rui%20Carmo)'s awesome [article](http://taoofmac.com/space/HOWTO/Vagrant).

We use salt to configure the the VirtualBox instance that's going to run all of the lxc containers, so we need the salt provisioner installed:

    vagrant plugin install vagrant-salt
    
Then just vagrant up & ssh into the new virtual machine:

    vagrant up
    vagrant ssh
    
Once you're in the virtual machine, some of the defaults have been adjusted to use lxc instead of VirtualBox.


