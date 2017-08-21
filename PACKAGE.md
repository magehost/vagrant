### PACKAGE

#### Test insecure SSH, must not ask password
```
# start the VM
ssh -i vagrant-insecure.key vagrant@[IP]
sudo su -
```

#### Package
Make sure the "magehostdev.pro" master box is registered in VirtualBox, otherwise export will fail.
Add 1 to the latest version from [catalog.json](http://vagrant.magehost.pro/catalog.json)
```
VERSION=7
{
set -e -x -u
cd ~/Code/vagrant
mv -f pub/*.box old/ || true
####  Parallels
prlctl unregister magehostdev.pro || true
rm -rf parallels/magehostdev.pro.pvm/*.{app,backup,log} parallels/magehostdev.pro.pvm/*~ parallels/magehostdev.pro.pvm/*.hdd/*.Backup || true
prl_disk_tool compact --hdd parallels/magehostdev.pro.pvm/*.hdd
tar -cvzf pub/xenial-apache-php7_prl_v${VERSION}.box -C parallels magehostdev.pro.pvm Vagrantfile metadata.json
####  VirtualBox
vagrant package --base magehostdev.pro --output pub/xenial-apache-php7_vb_v${VERSION}.box
####  VMware
virtualbox.vmwarevm/vmware-vdiskmanager -d virtualbox.vmwarevm/*.vmdk
virtualbox.vmwarevm/vmware-vdiskmanager -k virtualbox.vmwarevm/*.vmdk
tar -cvzf pub/xenial-apache-php7_vmw_v${VERSION}.box -C virtualbox.vmwarevm magehostdev.pro.{nvram,vmdk,vmsd,vmx,vmxf} metadata.json
#### Increase version + set checksum
ls -lah pub/*_v${VERSION}.box
md5 pub/*_v${VERSION}.box
# In catalog.json you need to create a new version block with 4x updated version number and 3x md5 sum.
joe pub/catalog.json && scp -P2222 pub/* vagrant@vagrant.magehost.pro:httpdocs/
}
```

### Install from local
Warning: creates linked clone. Please remove a.s.a.p. to prevent problems with further development of the master VM.
```
rm -rf ~/Code/vagrant/tmp/test; 
mkdir -p ~/Code/vagrant/tmp/test; 
cd ~/Code/vagrant/tmp/test
#
cp ~/Code/vagrant/pub/catalog.json ./catalog_local.json
gsed -i 's/http:\/\/.*\/\(.*\)\.box/file:\/\/\/Users\/jeroen\/code\/vagrant\/pub\/\1.box/g' ./catalog_local.json
cp ~/Code/vagrant/pub/Vagrantfile .
gsed -i 's/http:\/\/.*\/catalog\.json/file:\/\/catalog_local.json/g' ./Vagrantfile
rm -rf ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-xenial-apache-php7/$VERSION/*
rm -f ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-xenial-apache-php7/metadata_url
# vagrant up --provider virtualbox
# vagrant up --provider parallels
# vagrant up --provider vmware_fusion
```

### Destruct previous test
```
vagrant destroy -f
rm -rf ~/.vagrant.d/boxes/magehost-VAGRANTSLASH-xenial-apache-php7 Vagrantfile catalog_local.json httpdocs .bundle .vagrant
```
