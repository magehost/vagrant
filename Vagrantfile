# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.ssh.forward_agent   = true
    config.vm.box              = "magehost/trusty-apache-php5"
    config.vm.box_url          = "http://magentohosting.pro/vagrant/catalog.json"
    config.vm.network "private_network", type: "dhcp"
    config.vm.define "magehost_web" do |node|
        node.vm.synced_folder      "httpdocs", "/data/vhosts/magehostdev.pro/httpdocs", create: true
        node.vm.provision          "shell", inline: "/bin/bash /root/bin/provision.sh"
        node.vm.hostname           = 'magehostdev.pro'
        node.hostmanager.aliases   = %w(www.magehostdev.pro)
    end
    if Vagrant.has_plugin?("vagrant-hostmanager")
        config.hostmanager.enabled           = true
        config.hostmanager.manage_host       = true
        config.hostmanager.ignore_private_ip = false
        config.hostmanager.include_offline   = true
        config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
            if hostname = (vm.ssh_info && vm.ssh_info[:host])
                `vagrant ssh -c "/usr/local/bin/get_local_ip.sh eth1"`
            end
        end
    end
    config.vm.provider "parallels" do |prl|
        prl.update_guest_tools     = true
        prl.use_linked_clone       = true
    end
end
