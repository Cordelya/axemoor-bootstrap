#!/bin/bash

# =================================== #
# Axemoor Bootstrap Initialize Script #
# =================================== #

# First, some housekeeping
echo "Beginning system update and software install"
sudo apt update
sudo apt upgrade
$install="apache2 git mysql-client-core-8.0 openssh php7.4 systemctl
atom"
sudo apt install "$install"
echo "Done with software update and install"
# Apache Config
echo "Apache config starting now"
sudo mkdir /var/www/axemoor/public_html
sudo chown -R $USER:$USER /var/www/axemoor/public_html
sudo chmod -R 755 /var/www
sudo touch /etc/apache2/sites-available/axemoor.net.conf
$newconf="/etc/apache2/sites-available/axemoor.net.conf"
echo '<VirtualHost *:80>' >> $newconf
echo '    ServerAdmin webminister@axemoor.net' >> $newconf
echo '    ServerName axemoor.net' >> $newconf
echo '    ServerAlias www.axemoor.net' >> $newconf
echo '    DocumentRoot /var/www/html' >> $newconf
echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> $newconf
echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> $newconf
echo '</VirtualHost>' >> $newconf
sudo a2ensite axemoor.net.conf
sudo a2dissite 000-default.conf
echo "Attempting to restart Apache. Hang on."
sudo systemctl restart apache2
echo "Apache status is"
sudo systemctl status apache2

# git Config
read -p "Enter your name (may use SCA name here):" name
git config --global user.name "$name"
read -p "Enter your email address (DO NOT use webminister@axemoor.net):" email
git config --global user.email "$email"

# clone the Axemoor website repo
cd /var/www/axemoor/public_html
git clone https://github.com/Axemoor/website.git

# clone the Axemoor help system
mkdir ~/help
cd ~/help
git clone https://github.com/Cordelya/axemoor-bootstrap.git
PATH=$PATH:$HOME/help/
chmod +x axemoor.sh
echo "Setup is complete. Please type "axemoor.sh" at the command prompt and
press the Enter key"
