### PACKAGE

#### Test insecure SSH, must not ask password
```
# start the VM
ssh -i vagrant-insecure.key vagrant@[IP]
sudo su -
```

#### Package
```
VERSION=3
{
mv pub/*.box old/
####  VMware
virtualbox.vmwarevm/vmware-vdiskmanager -d virtualbox.vmwarevm/*.vmdk
virtualbox.vmwarevm/vmware-vdiskmanager -k virtualbox.vmwarevm/*.vmdk
tar -cvzf pub/xenial-apache-php7_vmw_v${VERSION}.box -C virtualbox.vmwarevm magehostdev.pro.{nvram,vmdk,vmsd,vmx,vmxf} metadata.json
####  VirtualBox
vagrant package --base magehostdev.pro --output pub/xenial-apache-php7_vb_v${VERSION}.box
####  Parallels
prlctl unregister magehostdev.pro
rm -rf parallels/magehostdev.pro.pvm/*.{app,backup,log} parallels/magehostdev.pro.pvm/*~ parallels/magehostdev.pro.pvm/*.hdd/*.Backup
prl_disk_tool compact --hdd parallels/magehostdev.pro.pvm/*.hdd
tar -cvzf pub/xenial-apache-php7_prl_v${VERSION}.box -C parallels magehostdev.pro.pvm Vagrantfile metadata.json
#### Increase version + set checksum
md5 pub/*_v${VERSION}.box
# In catalog.json you need to create a new version block with 3x updated version number and 2x md5 sum.
joe pub/catalog.json && vagrant push ftp
}
```

### Install from local
```
cd ~/Code/vagrant
rm -rf tmp/test
rm -rf ~/.vagrant.d/boxes/magehost-*
mkdir -p ~/Code/vagrant/tmp/test
cd tmp/test
cp ../../pub/catalog.json catalog_local.json
gsed -i 's/http:\/\/.*\/\(.*\)\.box/file:\/\/\/Users\/jeroen\/code\/vagrant\/pub\/\1.box/g' catalog_local.json
cp ../../pub/Vagrantfile .
gsed -i 's/http:\/\/.*\/catalog\.json/file:\/\/catalog_local.json/g' Vagrantfile
# vagrant up --provider virtualbox
# vagrant up --provider parallels
# vagrant up --provider vmware_fusion
```

### Destruct previous test
```
vagrant destroy -f
rm -rf ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-xenial-apache-php7 Vagrantfile catalog_local.json httpdocs .bundle .vagrant
```
