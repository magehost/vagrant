DocumentRoot       /data/vhosts/magehostdev.pro/httpdocs/
ErrorLog           /data/vhosts/magehostdev.pro/logs/error.log
CustomLog          /data/vhosts/magehostdev.pro/logs/access.log combined

<FilesMatch "\.php$">
    SetHandler "proxy:fcgi://127.0.0.1:9101"
</FilesMatch>

<Directory /data/vhosts/magehostdev.pro/httpdocs/>
    Require        all granted
    AllowOverride  All
    Options        +SymLinksIfOwnerMatch
</Directory>

# Include  includes/force_www.conf
# Include  includes/force_https.conf

Header  set  X-Robots-Tag  "none"
Alias   /mh_phpmyadmin  /usr/share/phpmyadmin

# SetEnv   MAGE_RUN_TYPE  "store"
# SetEnvIf  Host  (^|\.)domain1.ext$             MAGE_RUN_CODE=code1
# SetEnvIf  Host  (^|\.)domain2.ext$             MAGE_RUN_CODE=code2

