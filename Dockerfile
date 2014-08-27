#
# version 0.0.1
#
FROM phusion/baseimage:0.9.13
MAINTAINER someda "someda@nulab-inc.com"

CMD ["/sbin/my_init"]

# https://github.com/phusion/baseimage-docker#enabling-the-insecure-key-permanently
RUN /usr/sbin/enable_insecure_key

ADD ./www /srv/www
RUN chown -R www-data. /srv/www
RUN rm -fr /srv/www/sites/default/settings.php

ADD ./provision /srv/provision
ADD ./install_ansible.sh /var/tmp/install_ansible.sh

RUN /bin/bash /var/tmp/install_ansible.sh
RUN cd /srv/provision; ansible-playbook -i 127.0.0.1, -c local main.yml -vvv -e provisioned_env=docker

