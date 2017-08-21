#### Prepare Mac
```
brew install coreutils gnu-sed mysql
sudo gem install highline
```

### Open Parallels master image

    cd ~/Code/vagrant
    open parallels/magehostdev.pro.pvm
    
### Parallels to VirtualBox/VMware image

The Parallels disk needs to be one .hds file, not multiple. If you have multiple you need to remove snapshots.
If you then still have multiple you can mount the current disk and a new disk in another VM and use `dd` to clone there.

    {
        cd /data/repos/vagrant
        rm -i virtualbox.vmwarevm/magehostdev.pro.vmdk
        VBoxManage list hdds | grep "virtualbox.vmwarevm/magehostdev.pro.vmdk" && echo -e "Use 'File > Virtual Media Manager' to Release & Remove disk from Virtualbox.\n" && virtualbox 
        # You may need to Release & Remove the old disk inside VirtualBox: File > Virtual Media Manager
        FILES=$( find parallels/magehostdev.pro.pvm/magehostdev.pro.hdd -name '*.hds' )
        if [ 1 == $(echo -e "${FILES}" | wc -l) ]; then
            VBoxManage clonehd "${FILES}" virtualbox.vmwarevm/magehostdev.pro.vmdk  --format VMDK
        else
            echo -e "Multiple HDS files found, remove snapshots first:\n${FILES}"
        fi
    }

### Open VirtualBox/VMware master image in VirtualBox

    cd /data/repos/vagrant
    open virtualbox.vmwarevm/magehostdev.pro.vbox

### Open VirtualBox/VMware master image in VMware Fusion

    cd /data/repos/vagrant
    open virtualbox.vmwarevm/magehostdev.pro.vmx

### When ready

Execute via SSH in Parallels + VirtualBox master

    ~/bin/prepare_pack.sh
    
Now you can [package](https://github.com/magehost/vagrant/blob/xenial/PACKAGE.md).
