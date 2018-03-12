#!/usr/bin/env bash

usage() {
	cat << EOM

This script sends an email as configured by pfSense.

Usage:
	$(basename $0) "subject" "body"

EOM
	exit 1;
}

if [ "$#" -ne 2 ]
then
	>&2 echo "Invalid number of arguments"
	usage;
fi

echo "$2" | /usr/local/bin/mail.php -s"$1"
