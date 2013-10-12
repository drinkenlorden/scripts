#!/bin/bash

# STY - 2013-03-07
# TODO
# Put variables for RATE and CEIL

# Some VARIABLES - please change them to suit to your config

DEV=eth0
LOCAL_IP=
EXT_IP=
LAN_NET=
RATE=
CEIL=

# TC="/opt/sbin/tc"
TC="/sbin/tc"


if [ "$1" = "status" ]
then
        echo "[qdisc]"
        $TC -s qdisc show dev $DEV
        echo "[class]"
        $TC -s class show dev $DEV
        echo "[filter]"
        $TC -s filter show dev $DEV
        exit
fi

if [ "$1" = "stop" ]
then

 # Reset everything to a known state (cleared)
 $TC qdisc del dev $DEV root    2> /dev/null > /dev/null

 exit
fi

 # Reset everything to a known state (cleared)
 $TC qdisc del dev $DEV root    2> /dev/null > /dev/null


#/sbin/tc qdisc add dev $DEV root handle 1 htb default 40 r2q 100
/sbin/tc qdisc add dev $DEV root sfq perturb 10

echo TC Filter applyedon $DEV

