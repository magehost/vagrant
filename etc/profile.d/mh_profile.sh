#!/usr/bin/env bash

force_color_prompt=1

alias dirsize='du --max-depth=1 --block-size=M --one-file-system | sort -nr'
alias errlog='/usr/bin/tail -n0 -f \
 /var/log/syslog \
 /var/log/apache2/error.log \
 /var/log/mysql/error.log \
 /data/vhosts/*/logs/*error.log \
 /data/vhosts/*/httpdocs/var/log/*.log \
 /var/log/php*-fpm.log \
'

# Temp dir
export TMP=$HOME/tmp
export TMPDIR=$HOME/tmp
export TEMP=$HOME/tmp
/bin/mkdir -m700 -p $TMPDIR

# No core dumps
ulimit -c 0
