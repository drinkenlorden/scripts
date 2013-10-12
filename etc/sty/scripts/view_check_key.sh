#!/bin/bash

set -e

#openssl x509 -noout -text -purpose -in "$1"

echo "If no password will print the RSA/DSA key, if there is password will prompt for it"
echo 
echo

openssl rsa -check -in "$1"


echo  -e "\n====================\nTo change the passphrase for a key:
\nopenssl rsa -des3 -in keyfilename -out newkeyfilename
\nopenssl rsa -des3 -in "$1" -out new"$1"

\n"
