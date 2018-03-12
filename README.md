# Webpage Change Detector

This project holds scripts for checking for webpage changes and emailing when there are changes.
This script is based off (the script by bhfsteve)[http://bhfsteve.blogspot.com/2013/03/monitoring-web-page-for-changes-using.html].

## Getting Started

The scripts provided were written to run on a pfSense, but should be good to go on any system. The mail script will need to be changed to work on whatever system this is deployed to.

### Prerequisites

bash
curl

```
# FreeBSD
pkg install bash curl

# Debian
apt-get install bash curl

# Redhat
yum install bash curl
```

### Installing

No installation or changes are required for pfSense systems, just clone and execute to verify, and set up cron for any webpages you want to check.
For non-pfSense systems, you'll need to change mail.sh to send emails as you desire.

```
./monitor.sh https://www.google.com/ "Google Homepage"
```

```
# Check every six hours
0 */6 * * * monitor.sh https://www.google.com "Google Homepage"
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
