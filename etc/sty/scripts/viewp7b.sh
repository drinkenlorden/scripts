#!/bin/bash

set -x

openssl pkcs7 -inform DER -print_certs -text -noout -in "$1"
