#!/bin/sh -e

set -x

sed 's@http://us-east-1\.ec2\.archive\.ubuntu\.com/@http://old-releases.ubuntu.com/@' -i /etc/apt/sources.list
apt-get -y update
apt-get -y upgrade
apt-get -y install language-pack-en git curl wget python-stdeb devscripts
