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


/sbin/tc qdisc add dev $DEV root handle 1 htb default 40 r2q 100
/sbin/tc class add dev $DEV parent 1:2 classid 1:20 htb rate 1Mbit burst 15k
/sbin/tc qdisc add dev $DEV parent 1:20 handle 20 sfq perturb 10

/sbin/tc filter add dev $DEV parent 1:0 protocol ip prio 100 match ip src \
    	 192.168.171.0/24 classid 1:2

#/sbin/tc filter add dev $DEV parent 1:0 protocol ip prio 200 handle 20 fw classid 1:20

#tc filter add dev $DEV parent 999:0 protocol ip prio 99 handle ::1 u32 \
#    classid 1:2 \
#    match ip src 192.168.171.0/24 \
#    match ip tos 0x08 1e

echo TC Filter applyedon $DEV

