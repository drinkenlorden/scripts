#!/bin/bash

set -x

openssl x509 -noout -text -purpose -in "$1"
