#!/bin/bash
IP=""
DEVICES="em0 em1 em2 em3 eth0 eth1 eth2 eth1 en0 en1 en2"
if [ ! -z "$1" ]; then
    DEVICES="$1"
fi
for DEV in $DEVICES; do
    if [ -z "$IP" ]; then
        IP=$( /sbin/ifconfig ${DEV} 2>/dev/null | /usr/bin/gawk 'match($0,"addr:([0-9\\.]+)",a) { print a[1] }' )
    fi
done
echo -n $IP
