# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "magehost/trusty-apache-php5"
  config.vm.box_url = "http://magentohosting.pro/vagrant/catalog.json"

  config.vm.provider "parallels" do |prl|
    prl.name = "magehostdev"
    prl.update_guest_tools = true
  end
end
