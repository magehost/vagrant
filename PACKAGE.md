### Destruct previous test
```
vagrant destroy -f
rm -rf ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-trusty-apache-php5 Vagrantfile catalog_local.json httpdocs .bundle .vagrant
```

### Install from local
```
cp ../magehostdev/catalog.json catalog_local.json
gsed -i 's/http:\/\/.*\/\(.*\)\.box/file:\/\/\/Users\/jeroen\/vagrant\/magehostdev\/\1.box/g' catalog_local.json
cp ../magehostdev/Vagrantfile .
gsed -i 's/http:\/\/.*\/catalog\.json/file:\/\/catalog_local.json/g' Vagrantfile
vagrant up --provider virtualbox
```

### PACKAGE

#### Test insecure SSH
```
open box.pvm
ssh -i vagrant-insecure.key vagrant@[IP]
```

#### Package
```
VERSION=12
mv pub/*.box old/
####  Parallels
rm -rf parallels/box.pvm/*.{app,backup,log} parallels/box.pvm/*~ parallels/box.pvm/harddisk1.hdd/*.Backup
prl_disk_tool compact --hdd parallels/box.pvm/harddisk1.hdd
tar -cvzf pub/trusty-apache-php5_prl_v${VERSION}.box -C parallels box.pvm Vagrantfile metadata.json
####  VirtualBox
rm -f trusty-apache-php5_vb_v${VERSION}.box
vagrant package --base magehostdev.pro --output pub/trusty-apache-php5_vb_v${VERSION}.box
```

#### Increase version + set checksum
In each JSON file you need to update the version and the filename. In `catalog.json` also update the md5 sum.
```
md5 trusty-apache-php5_prl_v${VERSION}.box
md5 trusty-apache-php5_vb_v${VERSION}.box
joe catalog.json catalog_local.json
```

#### Upload
```
vagrant push ftp
```
