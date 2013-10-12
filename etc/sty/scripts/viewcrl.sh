#!/bin/bash

set -x

openssl crl -noout -text -in "$1"
