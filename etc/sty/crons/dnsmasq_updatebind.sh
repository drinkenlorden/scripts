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
nova=`basename $novaclient`
bstk=/var/lib/bstk

clear_markers() {
    f_path="$1"

    if [ -f "$f_path" ]; then
        sed -i '/'"$cfg_marker_start"'/,/'"$cfg_marker_end"'/d' $f_path
    fi
}

check_and_update(){

if [ -f $novaclient -a  $bstk/$nova.bkp ] ;then
    if ! diff $novaclient $bstk/$nova.bkp  &>/dev/null ; then
        clear_markers $bindnova
        cat >> $bindnova << EOF
$cfg_marker_start
$data
$cfg_marker_end
EOF
        /sbin/service named reload
    fi
fi

}

if [ -f $novaclient ] ;then
    data=`cat $novaclient | awk -F"," '{print $2"           IN   1H  A       "$3}'|sed -e 's/.novalocal//'|sed -e 's/.cloudrunner//'`
    #echo $data
else
    echo "File $novaclient not found"
fi

if [ -f $bindnova ] ;then
    cp $novaclient $bstk/$nova.bkp
    check_and_update
else
    echo "File $bindnova not found"
fi
