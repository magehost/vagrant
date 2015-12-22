# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "magehost/trusty-apache-php5"
  config.vm.box_url = "http://magentohosting.pro/vagrant/catalog.json"

  config.vm.provider "parallels" do |prl|
    # prl.name = "magehostdev"
    prl.update_guest_tools = true
  end
end
