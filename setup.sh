#!/bin/bash

#installations
apt-get update
apt-get install apache2 -y

#virtualhost

cp -r /etc/backups/grup8vc2324-html /var/www/grup8vc2324/
cp /etc/backups/grup8vc2324.conf /etc/apache2/sites-available
a2dissite 000-default.conf
a2ensite grup8vc2324.conf

#digest-autentication

a2enmod auth_digest
cp /etc/backups/passwords.digest /etc/apache2
chmod 640 /etc/apache2/passwords.digest
chown root.www-data /etc/apache2/passwords.digest

#basic-autentication

cp /etc/backups/ba-pw /etc/apache2

#webalizer

cp /etc/backups/webalizer.conf /etc/webalizer
cp /etc/backups/webalizer-vh.conf /etc/apache2/sites-available
sudo a2ensite webalizer-vh.conf
mkdir /usr/share/GeoDB
cp /etc/backups/GeoDB.dat /usr/share/GeoDB
crontab crontab_webalizer
(crontab -l; echo "* * * * * webalizer")|awk '!x[$0]++'|crontab -

#server-info

a2enmod info
cp /etc/backups/info.conf /etc/apache2/mods-available

#server-status

a2enmod status
cp /etc/backups/status.conf /etc/apache2/mods-available

#restart apache

systemctl restart apache2
