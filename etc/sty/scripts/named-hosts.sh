#!/bin/bash
#
# test DNS forward- and reverse-mapping
#

#NETS="192.168.1 192.168.15"
NETS="192.168.1"

# give some options to dig , for example @localhost, i yuo
# want to ask local DNS server
options="@127.0.0.1"

addr_to_name(){
# Test address to name to address validity
echo
echo -e "\taddress -> name -> address"
echo '-------------------------------------'
for NET in $NETS; do
  for n in $(seq 1 254); do
    A=${NET}.${n}
    HOST=$(dig -x $A +short $options)
    if test -n "$HOST"; then
      ADDR=$(dig $HOST +short $options)
      if test "$A" = "$ADDR"; then
        echo -e "ok\t$A -> $HOST -> $ADDR"
      elif test -n "$ADDR"; then
        echo -e "fail\t$A -> $HOST -> $ADDR"
      else
        echo -e "fail\t$A -> $HOST -> [unassigned]"
      fi
    fi
  done
done
}

name_to_addr(){
# Test name to address to name validity
echo
echo -e "\tname -> address -> name"
echo '----------------------------------'
while read H; do
  ADDR=$(dig $H +short)
  if test -n "$ADDR"; then
    HOST=$(dig -x $ADDR +short)
    if test "$H" = "$HOST"; then
      echo -e "ok\t$H -> $ADDR -> $HOST"
    elif test -n "$HOST"; then
      echo -e "fail\t$H -> $ADDR -> $HOST"
    else
      echo -e "fail\t$H -> $ADDR -> [unassigned]"
    fi
  else
    echo -e "fail\t$H -> [unassigned]"
  fi
done < named-hosts
}



# MAIN

addr_to_name
#name_to_addr
