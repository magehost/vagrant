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

**WORK IN PROGRESS**

The Parallels disk needs to be one .hds file, not multiple. If you have multiple you can mount the current disk and a new disk in another VM and use `dd` to clone there.

    cd ~/Code/vagrant
    rm -i virtualbox.vmwarevm/magehostdev.pro.vmdk
    # You may need to Release & Remove the old disk inside VirtualBox: File > Virtual Media Manager
    VBoxManage clonehd parallels/magehostdev.pro.pvm/magehostdev.pro.hdd/*.hds virtualbox.vmwarevm/magehostdev.pro.vmdk  --format VMDK

### When ready

Execute via SSH in Parallels + VirtualBox mater

    ~/bin/prepare_pack.sh
    
Now you can [package](https://github.com/magehost/vagrant/blob/xenial/PACKAGE.md).
