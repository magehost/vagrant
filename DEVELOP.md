#### Prepare Mac
```
brew install coreutils gnu-sed mysql
sudo gem install highline
```

### Open Parallels master image

    cd ~/Code/vagrant
    open parallels/magehostdev.pro.pvm
    
### Open VirtualBox/VMware master image in VirtualBox

    cd ~/Code/vagrant
    open virtualbox.vmwarevm/magehostdev.pro.vbox

### Open VirtualBox/VMware master image in VMware Fusion

    cd ~/Code/vagrant
    open virtualbox.vmwarevm/magehostdev.pro.vmx

### Parallels to VirtualBox/VMware image

The Parallels disk needs to be one .hds file, not multiple.
**WORK IN PROGRESS**

    cd ~/Code/vagrant
    VBoxManage clonehd parallels/magehostdev.pro.pvm/magehostdev.pro.hdd/magehostdev.pro.hds virtualbox.vmwarevm/magehostdev.pro.vmdk  --format VMDK

### When ready

Execute via SSH in Parallels + VirtualBox mater

    ~/bin/prepare_pack.sh
    
Now you can [package](https://github.com/magehost/vagrant/blob/xenial/PACKAGE.md).
