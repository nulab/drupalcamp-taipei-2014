# Examples how to develop and operate Drupal on Vagrant and Docker

## Prerequisites

* [Vagrant 1.6 or later](http://docs.vagrantup.com/v2/installation/index.html)
* [Docker 1.1.2 or later](https://www.docker.com/)

## Vagrant

### Start environment

    vagrant up

After successfully startup, access to http://172.28.128.4 and login by `admin` with password `admin`.

Once you download the basic box, it will take about 7,8 minutes to start environment from scratch.

### Clean up environment

    vagrant destroy -f
    rm -f www/sites/default/settings.php
    vagrant up

## Docker

### Start environment

Start mysql container first since Docker image doesn't contain MySQL.

    docker run --name mysql-drupal -e MYSQL_USER=drupal -e MYSQL_PASSWORD=drupal -e MYSQL_ROOT_PASSWORD=drupal -e MYSQL_DATABASE=drupal -d -p 3306:3306 mysql:5.6.20

After starting mysql container, run your Drupal container next.

    docker run --name drupal --link mysql-drupal:mysql -p 8080:80 -i -t tksmd/drupalcamp-taipei-2014 /sbin/my_init -- bash -l

You can detach from container by typing `^P^Q`.

### Clean up environment

    docker rm -f drupal
    docker rm -f mysql-drupal

### Build Image

If you want to build your own Docker image, do the following.

    docker build -t <yourtag> .
