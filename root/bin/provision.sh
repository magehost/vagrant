#!/bin/bash
echo "--- development Vagrant box by MagentoHosting.pro ----"
echo ""
user="vagrant"
ip=$( /usr/local/bin/get_local_ip.sh eth1 )
home="/data/vhosts/magehostdev.pro"

# workaround to make sure we have both numbers and letters
apppass="$( /usr/bin/makepasswd --minchars=3 --maxchars=9 )A1$( /usr/bin/makepasswd --minchars=3 --maxchars=9 )"

if [ -f $home/.my.cnf ]; then
    pass=$( cat $home/.my.cnf | grep '^password=' | cut -d'=' -f2 )
else
    pass="vagrant"   
    touch $home/.my.cnf
    chmod 600 $home/.my.cnf
    chown $user: $home/.my.cnf
    cat <<EOF > $home/.my.cnf
[client]
user=$user
password=$pass
# Database name: $user
# PhpMyAdmin:    http://$ip/mh_phpmyadmin/
EOF
fi

webroot="$home/httpdocs"
if [ ! -f "$webroot/index.php" ]; then
    # chown is not possible because of NFS
    sudo -u vagrant cat <<EOF > $webroot/index.php
<h1><?= 'It works.'; ?></h1>
<p><?php echo date('r'); ?></p>
EOF
fi

/bin/echo "vagrant:$pass" | /usr/sbin/chpasswd
/usr/bin/mysql -u root -e "GRANT ALL ON *.* TO '$user'@'%' IDENTIFIED BY '$pass' WITH GRANT OPTION; FLUSH PRIVILEGES;"

/usr/local/bin/n98-magerun.phar selfupdate -q
cp /etc/n98-magerun.yaml $home/.n98-magerun.yaml
chmod 600 $home/.n98-magerun.yaml
chown vagrant: $home/.n98-magerun.yaml
sed -i "s/___PWD___/$apppass/g" $home/.n98-magerun.yaml

cat <<EOF
SSH + MySQL User:       $user
SSH + MySQL Password:   $pass
      MySQL Database:   $user

SSH Server:       $ip  port  22
Web Server:       http://$ip/
PhpMyAdmin:       http://$ip/mh_phpmyadmin/
Tools installed:  git subversion n98-magerun modman vim joe nano dos2unix

The 'httpdocs' dir on your workstation is mounted as webroot inside the Vagrant box.

Example Magento install, execute on your local workstation:
  vagrant ssh -c  "n98-magerun.phar install --installationFolder=./httpdocs --dbHost=$ip --dbUser=vagrant --dbPass=$pass --dbName=vagrant --baseUrl=http://$ip/ --useDefaultConfigParams=yes"
  vagrant ssh -c  "cd httpdocs ;  test -d .modman || modman init ;  modman clone --copy --force https://github.com/Inchoo/Inchoo_PHP7.git ;  n98-magerun.phar cache:clean config"
After executing this you will be able to log in on  http://$ip/backend/  with the user "vagrant", password "$apppass"
EOF
