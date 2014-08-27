#!/usr/bin/env bash
#
#

# when this script runs first on the target host, update default package and install ansible to provision
if [ ! -x /usr/bin/ansible ]; then
  apt-get update
  apt-get dist-upgrade
  apt-get install ansible python-apt -y
fi
