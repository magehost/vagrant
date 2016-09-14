#!/bin/bash
service apache2 stop
service php5-fpm stop
service mysql stop
/usr/bin/mysqladmin -f drop vagrant > /dev/null
git -C /data/repos/vagrant pull
/root/bin/updatetools.sh
apt-get update
apt-get -y upgrade
apt-get -y upgrade linux-generic linux-headers-generic linux-image-generic
apt-get clean
rm -f   /data/mysql/ib_logfile* /data/mysql_log/*
rm -rf  /root/.history /data/vhosts/magehostdev.pro/.history
rm -rf  /data/vhosts/magehostdev.pro/httpdocs/*  /data/vhosts/magehostdev.pro/httpdocs/.my.cnf
cp -avf /data/repos/vagrant/data/vhosts/magehostdev.pro/*  /data/vhosts/magehostdev.pro/
rm -rf  /tmp/*
rm -rf  /data/vhosts/magehostdev.pro/tmp/*
rm -rf  /data/vhosts/magehostdev.pro/php-session/sess_*
rm -f   /data/mysql/*.err
umount  /var/lib/lxcfs
find  / -name '*~' -delete
find  /var/log -type f -name '*.gz' -delete
find  /var/log -type f -exec truncate -s 0 {} \;
find  /data/vhosts/magehostdev.pro/logs -type f -exec truncate -s 0 {} \;
umount /data/vhosts/magehostdev.pro/httpdocs 2>/dev/null
rm -rf /data/vhosts/magehostdev.pro/httpdocs/{.??,}*
echo "<h1>Error: <code>httpdocs</code> is not mounted</h1><?php echo date('r'); ?>" > /data/vhosts/magehostdev.pro/httpdocs/index.php
rm -f /data/vhosts/magehostdev.pro/.my.cnf
cd /
/root/bin/zero_freespace.sh
poweroff
