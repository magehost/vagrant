#!/bin/bash
/usr/bin/find /usr/local/share/n98-magerun/modules/ -mindepth 1 -maxdepth 1 -type d -exec git -C {} pull \;
/usr/bin/wget --no-check-certificate https://raw.githubusercontent.com/colinmollenhour/modman/master/modman -O /usr/local/bin/modman;
/usr/local/bin/composer.phar selfupdate
/usr/local/bin/n98-magerun.phar --skip-root-check selfupdate
/usr/local/bin/n98-magerun2.phar --skip-root-check selfupdate
