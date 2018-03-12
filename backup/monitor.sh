#!/usr/local/bin/bash

# monitor.sh - Monitors a web page for changes
# sends an email notification if the file change

# Usage:
#  monitor.sh URL DESCRIPTIVE_NAME
# cron:
#  0 */6 * * * monitor.sh URL DESCRIPTIVE_NAME
#  (every 6 hours)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PAGEDIR=$DIR/pages

URL="$1"
DESCRIPTION="$2"
HTML="`echo $2 | sed -E 's/[[:space:]]+/_/g' | sed -E 's/[^_[:alnum:]]//g' | tr '[:upper:]' '[:lower:]'`"

mv $PAGEDIR/$HTML.html $PAGEDIR/$HTML-old.html 2> /dev/null
curl $URL -L --compressed -s > $PAGEDIR/$HTML.html
DIFF_OUTPUT="$(diff $PAGEDIR/$HTML.html $PAGEDIR/$HTML-old.html)"
if [ "0" != "${#DIFF_OUTPUT}" ]; then
	echo "Visit it at $URL" | /usr/local/bin/mail.php -s"Web page changed: $DESCRIPTION"
fi
