#!/bin/bash

# TODO:
# Do not rearrange the file - aka keep the position of markers, as now
# we clear them and always add them at the end
set -e

# dnsmasq novalocal network dns configuration file
novaclient=/var/lib/nova/networks/nova-br100.conf
# markers for BIND zone file configuration
cfg_marker_start="; ; ; mark BEGIN ; ; ;"
cfg_marker_end="; ; ; BSTK END ; ; ;"
# BIND novaclient zone
bindnova=/var/named/chroot/var/named/db.novalocal


clear_markers() {
    f_path="$1"

    if [ -f "$f_path" ]; then
        sed -i '/'"$cfg_marker_start"'/,/'"$cfg_marker_end"'/d' $f_path
    fi
}

if [ -f $novaclient ] ;then
    data=`cat $novaclient | awk -F"," '{print $2"           IN   1H  A       "$3}'|sed -e 's/.novalocal//'`
    #echo $data
else
    echo "File $novaclient not found"
fi

if [ -f $bindnova ] ;then
    clear_markers $bindnova
    cat >> $bindnova << EOF
    $cfg_marker_start
    $data
    $cfg_marker_end
EOF
else
    echo "File $bindnova not found"
fi

