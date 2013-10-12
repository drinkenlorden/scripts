#!/bin/bash

(
	echo "openssl pkcs12 -clcerts -nokeys -nodes -in \"$1\" | openssl x509 -noout -text -purpose"
	echo "-------------------------------------------------------------------------------"
        openssl pkcs12 -clcerts -nokeys -nodes -in "$1" | openssl x509 -noout -text -purpose

	echo
	echo "==============================================================================="
	echo

	echo "openssl pkcs12 -info -nodes -in \"$1\""
	echo "-------------------------------------------------------------------------------"
	openssl pkcs12 -info -nodes -in "$1"
	echo "-------------------------------------------------------------------------------"

) 2>&1

exit 0
