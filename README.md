### USE

* First [Install Vagrant](http://www.vagrantup.com/download)

#### Install from our web server:
```
vagrant plugin install vagrant-parallels
wget https://magentohosting.pro/vagrant/Vagrantfile
vagrant up
```

#### Install from Atlas
```
vagrant init magehost/trusty-apache-php5
vagrant up --provider parallels
```


### PACKAGE

#### Test insecure SSH
```
open box.pvm
ssh -i vagrant-insecure.key vagrant@[IP]
```

#### Clean up & Package
```
VERSION=1
rm -rf ./box.pvm/*.log ./box.pvm/*~ ./box.pvm/*.backup ./box.pvm/*.app
prl_disk_tool compact --hdd ./box.pvm/harddisk1.hdd
tar -cvzf trusty-apache-php5_v${VERSION}.box ./box.pvm ./Vagrantfile ./metadata.json
shasum -a256 trusty-apache-php5_v${VERSION}.box
```

#### Increase version + set checksum
```
joe catalog.json catalog_local.json
```

#### Upload
```
scp -P2222 trusty-apache-php5_v${VERSION}.box catalog.json Vagrantfile maghopro@sun:httpdocs/vagrant/
```
