#!/bin/bash
echo "--- development Vagrant box by MagentoHosting.pro ----"
echo ""
user="vagrant"
ip=$( /usr/local/bin/get_local_ip.sh eth1 )
home="/data/vhosts/magehostdev.pro"

if [ -f $home/.my.cnf ]; then
    pass=$( cat $home/.my.cnf | grep '^password=' | cut -d'=' -f2 )
else
    # workaround to make sure we have both numbers and letters
    pass="$( /usr/bin/makepasswd --minchars=2 --maxchars=9 )A1$( /usr/bin/makepasswd --minchars=2 --maxchars=9 )"
    touch $home/.my.cnf
    chmod 600 $home/.my.cnf
    chown $user: $home/.my.cnf
    cat <<EOF > $home/.my.cnf
[client]
user=$user
password=$pass
database=$user
# PhpMyAdmin: http://$ip/mh_phpmyadmin/
EOF
fi

webroot="$home/httpdocs"
if [ ! -f "$webroot/index.php" ]; then
    cat <<EOF > $webroot/index.php
<h1><?= 'It works.'; ?></h1>
<p><?php echo date('r'); ?></p>
EOF
    chown $user: $webroot/index.php
    chmod 644 $webroot/index.php
fi

/bin/echo "vagrant:$pass" | /usr/sbin/chpasswd
/usr/bin/mysql -u root -e "GRANT ALL ON *.* TO '$user'@'%' IDENTIFIED BY '$pass' WITH GRANT OPTION; FLUSH PRIVILEGES;"

/usr/local/bin/n98-magerun.phar selfupdate -q
cp /etc/n98-magerun.yaml $home/.n98-magerun.yaml
chmod 600 $home/.n98-magerun.yaml
chown vagrant: $home/.n98-magerun.yaml
sed -i "s/___PWD___/$pass/g" $home/.n98-magerun.yaml

cat <<EOF
SSH + MySQL User:       $user
SSH + MySQL Password:   $pass    <== Save in a secure place.
      MySQL Database:   $user

SSH Server:       $ip  port  22
Web Server:       http://$ip/
PhpMyAdmin:       http://$ip/mh_phpmyadmin/
Tools installed:  git subversion n98-magerun modman vim joe nano dos2unix

The 'httpdocs' dir on your workstation is mounted as webroot inside the Vagrant box.

Example Magento install, execute on your local workstation:
  vagrant ssh -c  "n98-magerun.phar install --installationFolder=./httpdocs --dbHost=$ip --dbUser=vagrant --dbPass=$pass --dbName=vagrant --baseUrl=http://$ip/ --useDefaultConfigParams=yes"
After executing this you will be able to log in on  http://$ip/backend/  with the user "vagrant", password "$pass"
EOF
