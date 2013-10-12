#!/bin/bash



(
	echo "openssl pkcs12 -clcerts -nokeys -nodes -in \"$1\" | openssl x509 -noout -text -purpose"
	echo "-------------------------------------------------------------------------------"
	PASS='' openssl pkcs12 -passin env:PASS -clcerts -nokeys -nodes -in "$1" | openssl x509 -noout -text -purpose

	echo
	echo "==============================================================================="
	echo

	echo "openssl pkcs12 -info -nodes -in \"$1\""
	echo "-------------------------------------------------------------------------------"
	PASS='' openssl pkcs12 -info -nodes -passin env:PASS -in "$1"
	echo "-------------------------------------------------------------------------------"

	echo "Press 'q' to quit"
) 2>&1 | less

exit 0

# Several commands accept password arguments, typically using -passin
# and -passout for input and output passwords respectively. These allow
# the password to be obtained from a variety of sources. Both of these
# options take a single argument whose format is described below. If no
# password argument is given and a password is required then the user
# is prompted to enter one: this will typically be read from the current
# terminal with echoing turned off.
# 
# pass:password
#     the actual password is password. Since the password is visible to
# utilities (like 'ps' under Unix) this form should only be used where
# security is not important.
# 
# env:var
#     obtain the password from the environment variable var. Since the
# environment of other processes is visible on certain platforms (e.g.
# ps under certain Unix OSes) this option should be used with caution.
# 
# file:pathname
#     the first line of pathname is the password. If the same pathname
# argument is supplied to -passin and -passout arguments then the first
# line will be used for the input password and the next line for the
# output password. pathname need not refer to a regular file: it could
# for example refer to a device or named pipe.
# 
# fd:number
#     read the password from the file descriptor number. This can be
# used to send the data via a pipe for example.
# 
# stdin
#     read the password from standard input.
# 
