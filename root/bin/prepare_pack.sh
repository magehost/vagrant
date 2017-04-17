#!/bin/bash
echo "==== Dropping 'vagrant' MySQL db..."
/usr/bin/mysqladmin -f drop vagrant 2>/dev/null
echo "==== Stopping Apache, PHP-FPM, MySQL..."
systemctl stop apache2 php7.0-fpm mysql
echo "==== Updating Git + pruning history..."
git -C /data/repos/vagrant pull
git -C /data/repos/vagrant fetch --depth=1
git -C /data/repos/vagrant reflog expire --expire-unreachable=now --all
git -C /data/repos/vagrant gc --aggressive --prune=all
echo "==== Updating Tools..."
/root/bin/updatetools.sh
echo "==== Updating OS..."
apt-get update
apt-get -y upgrade
apt-get -y upgrade linux-generic linux-headers-generic linux-image-generic
apt-get -y autoremove
apt-get clean
update-grub
echo "==== Cleaning logs..."
rm -f   /data/mysql/ib_logfile*  /data/mysql_log/*
rm -rf  /root/.history  /home/*/.history  /data/vhosts/*/.history
echo "==== Cleaning temp files, caches and logs..."
umount  /var/lib/lxcfs
rm -rf  /tmp/*
rm -rf  /data/vhosts/*/tmp/*
rm -rf  /data/vhosts/*/php-session/sess_*
rm -f   /data/mysql/*.err
find  / -name '*~' -delete
find  / -depth -name '.cache' -exec rm -rf {} \;
find  /var/log -type f -name '*.gz' -delete
find  /var/log -type f -exec truncate -s 0 {} \;
find  /data/vhosts/*/logs -type f -exec truncate -s 0 {} \;
echo "==== Restoring empty vhost..."
umount /data/vhosts/magehostdev.pro/magento1 2>/dev/null
umount /data/vhosts/magehostdev.pro/magento2 2>/dev/null
rm -f /data/vhosts/magehostdev.pro/.my.cnf
rm -rf /data/vhosts/magehostdev.pro/magento1/{.??,}* 2>/dev/null
rm -rf /data/vhosts/magehostdev.pro/magento2/{.??,}* 2>/dev/null
cp -avf /data/repos/vagrant/data/vhosts/magehostdev.pro/*  /data/vhosts/magehostdev.pro/
chown -R vagrant: /data/vhosts/magehostdev.pro
cd /
echo "==== Zero free space..."
/root/bin/zero_freespace.sh
echo "==== Shutting down..."
poweroff
