#!/bin/bash
#
# https://github.com/orvice/lnmp
# @orvice
# http://orvice.org
# orvice@gmail.com
# last update 2014-11-18


# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must  run this script as root"
    exit 1
fi

#Add MariaDB
# https://downloads.mariadb.org/mariadb/repositories/#mirror=osuosl&distro=Debian&distro_release=wheezy&version=5.5
#apt-get install python-software-properties -y
#apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
#add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/debian wheezy main'





#Add Dotdeb
echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
cd /tmp
wget http://www.dotdeb.org/dotdeb.gpg
apt-key add  dotdeb.gpg

#Update
apt-get update
apt-get upgrade

#Remove Apache
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker

#Install Nginx MySQL
apt-get install -y nginx-full mysql-server mysql-client

#Install PHP
apt-get install php5-fpm php5-gd php5-mysql php5-memcache php5-curl php5-cli memcached -y

#Start Nginx
service nginx start

#Add group&user: www and mysql
groupadd www
useradd -s /sbin/nologin -M -g www www
groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql

#Add dir
mkdir /home/www
mkdir /home/www/default
chown www:www /home/www -R

#Set Permission
chown www:www /var/lib/nginx/fastcgi -R
chown www:www /home/www -R

#Edit Nginx
cd /etc/nginx
rm nginx.conf
mkdir vhost
wget https://raw.githubusercontent.com/orvice/lnmp/master/nginx.conf
cd /etc/nginx/vhost
wget https://raw.githubusercontent.com/orvice/lnmp/master/nginx/vhost/default.conf

#Edit php5-fpm
cd /etc/php5/fpm/pool.d
rm www.conf
wget https://raw.githubusercontent.com/orvice/lnmp/master/php-fpm/www.conf

#touch
mkdir /usr/share/nginx/www/
cd /usr/share/nginx/www/
touch 50x.html

#restart
service nginx restart
service php5-fpm restart
