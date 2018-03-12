#!/usr/bin/env bash

usage() {
	cat << EOM

This script monitors a web page for changes and sends an email notification if the file change

Usage:
	$(basename $0) URL DESCRIPTIVE_NAME
	
	URL: The url for the script to check for changes
	DESCRIPTIVE_NAME: A descriptive name for the email

Cron:
	0 */6 * * * $(basename $0) URL DESCRIPTIVE_NAME
	(every 6 hours)

EOM
	exit 1;
}

if [ "$#" -ne 2 ]
then
	>&2 echo "Invalid number of arguments"
	usage;
fi

# Setup the environment
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PAGEDIR=$DIR/pages
mkdir -p "$PAGEDIR"

# Manipulate arguments into html filename
URL="$1"
DESCRIPTION="$2"
HTML="`echo $2 | sed -E 's/[[:space:]]+/_/g' | sed -E 's/[^_[:alnum:]]//g' | tr '[:upper:]' '[:lower:]'`"

# Move the last fetch to the "old" version, then get and diff current version
mv $PAGEDIR/$HTML.html $PAGEDIR/$HTML-old.html 2> /dev/null
curl $URL -L --compressed -s > $PAGEDIR/$HTML.html
DIFF_OUTPUT="$(diff $PAGEDIR/$HTML.html $PAGEDIR/$HTML-old.html)"
if [ "0" != "${#DIFF_OUTPUT}" ]; then
	$DIR/mail.sh "Web page changed: $DESCRIPTION" "Visit it at $URL"
fi
