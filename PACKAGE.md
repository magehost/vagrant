### PACKAGE

#### Test insecure SSH
```
open box.pvm
ssh -i vagrant-insecure.key vagrant@[IP]
```

#### Package
```
VERSION=1
mv pub/*.box old/
####  Parallels
# prlctl unregister magehostdev.pro
# rm -rf parallels/box.pvm/*.{app,backup,log} parallels/box.pvm/*~ parallels/box.pvm/*.hdd/*.Backup
# prl_disk_tool compact --hdd parallels/box.pvm/*.hdd
# tar -cvzf pub/xenial-apache-php7_prl_v${VERSION}.box -C parallels box.pvm Vagrantfile metadata.json
####  VMware
virtualbox.vmwarevm/vmware-vdiskmanager -d virtualbox.vmwarevm/*.vmdk
virtualbox.vmwarevm/vmware-vdiskmanager -k virtualbox.vmwarevm/*.vmdk
tar -cvzf pub/xenial-apache-php7_vmw_v${VERSION}.box -C virtualbox.vmwarevm magehostdev.pro.{nvram,vmdk,vmsd,vmx,vmxf} 
####  VirtualBox
vagrant package --base magehostdev.pro --output pub/xenial-apache-php7_vb_v${VERSION}.box
#### Increase version + set checksum
md5 pub/*_v${VERSION}.box
# In catalog.json you need to create a new version block with 3x updated version number and 2x md5 sum.
joe pub/catalog.json && vagrant push ftp
```

#### Prepare Mac
```
brew install coreutils gnu-sed mysql
```

### Destruct previous test
```
vagrant destroy -f
rm -rf ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-xenial-apache-php7 Vagrantfile catalog_local.json httpdocs .bundle .vagrant
```

### Install from local
```
rm -rf tmp/testvb
mkdir -p tmp/testvb
cd tmp/testvb
cp ../../pub/catalog.json catalog_local.json
gsed -i 's/http:\/\/.*\/\(.*\)\.box/file:\/\/\/Users\/jeroen\/code\/vagrant\/pub\/\1.box/g' catalog_local.json
cp ../../pub/Vagrantfile .
gsed -i 's/http:\/\/.*\/catalog\.json/file:\/\/catalog_local.json/g' Vagrantfile
vagrant up --provider virtualbox
```
