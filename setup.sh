#!/bin/bash

#installations
sudo apt-get update
sudo apt-get install apache2 -y

#virtualhost

sudo cp -r /etc/backups/grup8vc2324-html /var/www/grup8vc2324/
sudo cp /etc/backups/grup8vc2324.conf /etc/apache2/sites-available
sudo a2dissite 000-default.conf
sudo a2ensite grup8vc2324.conf

#digest-autentication

sudo a2enmod auth_digest
sudo cp /etc/backups/passwords.digest /etc/apache2
sudo chmod 640 /etc/apache2/passwords.digest
sudo chown root.www-data /etc/apache2/passwords.digest

#basic-autentication

sudo cp /etc/backups/ba-pw /etc/apache2

#webalizer

sudo cp /etc/backups/webalizer.conf /etc/webalizer
sudo cp /etc/backups/webalizer-vh.conf /etc/apache2/sites-available
sudo a2ensite webalizer-vh.conf
sudo mkdir /usr/share/GeoDB
sudo cp /etc/backups/GeoDB.dat /usr/share/GeoDB
sudo crontab crontab_webalizer
sudo (crontab -l; echo "* * * * * webalizer")|awk '!x[$0]++'|crontab -

#server-info

sudo a2enmod info
sudo cp /etc/backups/info.conf /etc/apache2/mods-available

#server-status

sudo a2enmod status
sudo cp /etc/backups/status.conf /etc/apache2/mods-available

#restart apache

sudo systemctl restart apache2