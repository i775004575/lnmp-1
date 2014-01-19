#!/bin/bash

#https://github.com/orvice/lnmp

#Add Dotdeb
echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
wget http://www.dotdeb.org/dotdeb.gpg 
apt-key add  dotdeb.gpg


#Add MariaDB

apt-key adv –recv-keys –keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
add-apt-repository ‘deb http://mirror.jmu.edu/pub/mariadb/repo/5.5/debian wheezy main’

#Update
apt-get update

#Install Nginx
apt-get install -y nginx-full -y

#Install MariaDB
apt-get install python-software-properties -y
apt-get install mariadb-server -y

#Install PHP 
apt-get install php5-fpm php5-gd php5-mysql php5-memcache php5-curl memcached -y

#Start Nginx
service nginx start
