#!/bin/bash


help(){

    echo Usage:
    echo "`basename $0` -h,--help    Print this help"
    echo "`basename $0` -a, --all    Print all processes in swap, even with 0 usage"
}
swap_per_process(){
# Get current swap usage for all running processes
# Erik Ljungstrom 27/05/2011

SUM=0
OVERALL=0

for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"` ; do
    PID=`echo $DIR | cut -d / -f 3`
    PROGNAME=`ps -p $PID -o comm --no-headers`

    for SWAP in `grep Swap $DIR/smaps 2>/dev/null| awk '{ print $2 }'`
        do
            let SUM=$SUM+$SWAP
    done

    echo "PID=$PID - Swap used: $SUM - ($PROGNAME )"
    let OVERALL=$OVERALL+$SUM
    SUM=0
done

echo "Overall swap used: $OVERALL"
}

case "$1" in
    -h|--help)
        help
    ;;

    -a)
        swap_per_process
    ;;

    *)
        swap_per_process | egrep -v "Swap used: 0" |sort -n -k 5
    ;;
esac
