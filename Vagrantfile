Vagrant.configure(2) do |config|
    config.vm.box              = "magehost/trusty-apache-php5"
    config.vm.box_url          = "http://magentohosting.pro/vagrant/catalog.json"
    config.vm.define "magehost_web" do |node|
    end
    config.push.define "ftp" do |push|
       push.secure = true
       push.host = "sun.magehost.pro:2222"
       push.username = "maghopro"
       push.destination = "/data/vhosts/magentohosting.pro/httpdocs/vagrant"
#       push.password = ""
    end
end
