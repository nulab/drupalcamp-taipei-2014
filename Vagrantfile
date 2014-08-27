# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "trusty64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "drupal"
  config.vm.network "private_network", ip: "172.28.128.4"

  # disabled due to VirtualBox 4.3.10 bug, for details, see https://github.com/mitchellh/vagrant/issues/3341
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  # VVV style mount
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "www/", "/srv/www/", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
  config.vm.synced_folder "provision/", "/srv/provision"
#  config.vm.synced_folder "www/", "/srv/www/", type: "nfs"

  config.vm.provision "shell", path: "install_ansible.sh"
  config.vm.provision "shell", inline: "cd /srv/provision; ansible-playbook -i 127.0.0.1, -c local main.yml -vvv -e provisioned_env=vagrant -e mysql_host=localhost"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

end
