# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.ssh.forward_agent = true

  config.vm.box = "magehost/trusty-apache-php5"
  config.vm.box_url = "http://magentohosting.pro/vagrant/catalog.json"
  config.vm.define "magehost" do |magehost|
  end

  config.vm.provider "parallels" do |prl|
    # prl.name = "magehostdev"
    prl.update_guest_tools = true
  end
end
