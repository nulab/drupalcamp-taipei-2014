#!/usr/bin/env bash
#
#

LOCAL_PYTHON_VER="2.7.8"
LOCAL_PYTHON_PATH="/root/local/python-${LOCAL_PYTHON_VER}"

# install python for ansible provisioning

if [ ! -d "${LOCAL_PYTHON_PATH}" ]; then
  apt-get update
  apt-get install git -y
  apt-get install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libyaml-dev -y
  git clone https://github.com/tagomoris/xbuild.git /root/xbuild
  mkdir -p /root/local
  /root/xbuild/python-install ${LOCAL_PYTHON_VER} ${LOCAL_PYTHON_PATH}
fi

export PATH=${LOCAL_PYTHON_PATH}/bin:${PATH}
if [ ! -x ${LOCAL_PYTHON_PATH}/bin/ansible ]; then
  pip install ansible
fi

cd /srv/provision
ansible-playbook -i 127.0.0.1, -c local main.yml -vvv