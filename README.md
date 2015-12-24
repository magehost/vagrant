### USE

* First you need to [Install Vagrant](http://www.vagrantup.com/download)

#### Install from Atlas
```
vagrant plugin install vagrant-parallels vagrant-hostmanager
vagrant init magehost/trusty-apache-php5
vagrant login
vagrant up
```

#### Install from our web server:
```
vagrant plugin install vagrant-parallels vagrant-hostmanager
wget https://magentohosting.pro/vagrant/Vagrantfile
vagrant up
```

### Install from local test - destructive
```
vagrant plugin install vagrant-parallels vagrant-hostmanager
vagrant destroy -f
rm -rf ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-trusty-apache-php5
rm -rf .bundle .vagrant httpdocs
cp ../magehostdev/Vagrantfile.local Vagrantfile
vagrant up
```

### PACKAGE

#### Test insecure SSH
```
open box.pvm
ssh -i vagrant-insecure.key vagrant@[IP]
```

#### Clean up & Package
```
VERSION=7
rm -rf ./box.pvm/*.log ./box.pvm/*~ ./box.pvm/*.backup ./box.pvm/harddisk1.hdd/*.Backup ./box.pvm/*.app
prl_disk_tool compact --hdd ./box.pvm/harddisk1.hdd
tar -cvzf trusty-apache-php5_v${VERSION}.box  box.pvm Vagrantfile metadata.json
```

#### Increase version + set checksum
In each JSON file you need to update the version and the filename. In `catalog.json` also update the md5 sum.
```
md5 trusty-apache-php5_v${VERSION}.box
joe catalog.json catalog_local.json
```

#### Upload
```
scp -P2222 trusty-apache-php5_v${VERSION}.box catalog.json Vagrantfile maghopro@sun:httpdocs/vagrant/
```
