#!/bin/bash

set -x

openssl pkcs12 -in "$1" -out "${1/.p12/.pem}"

# no password
#openssl pkcs12 -in "$1" -out "${1/.p12/.pem}" -nodes
