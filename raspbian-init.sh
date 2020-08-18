#!/bin/bash

# =================================== #
# Axemoor Bootstrap Initialize Script #
# =================================== #
# Raspbian Edition

# First, some housekeeping
echo "Beginning software update"
sudo apt update > /dev/null
sudo apt upgrade > -y /dev/null
echo "Software update complete"

$install2="php libcache2-mod-php git systemctl"
$install3="mariadb-server"
sudo apt install apache2 -y > /dev/null
echo "Done with Apache2"
echo "Enable & Start SSH"
sudo systemctl enable ssh
sudo systemctl start ssh
echo "Done with SSH"
# Apache Config
echo "Apache config starting now"
# Check for /var/www. If not found, apache2 install failed 
# and we need to abort the install.
if [ ! -d "/var/www" ];
  then echo "Apache didn't install correctly. Aborting." && exit
fi
# Check for /var/www/axemoor. If not exist, make
if [ ! -d "/var/www/axemoor" ];
  then
  sudo mkdir /var/www/axemoor/public_html -p
  sudo chown -R $USER:$USER /var/www/axemoor/public_html
  sudo chmod -R 755 /var/www
fi
# Check for axemoor.net.conf in sites-available. If not exist, make.
if [ ! -f "/etc/apache2/sites-available/axemoor.net.conf" ];
  then
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
fi

echo "Attempting to restart Apache. Hang on."
sudo systemctl restart apache2
echo "Apache status is"
sudo systemctl status apache2
echo "Done configuring Apache. Now installing additional software."
sudo apt install "$install2" -y #php libcache2-mod-php git systemctl
sudo apt-get install "$install3" -y #mariadb-server
RED='\033[0;31m'
NC='\033[0m'
echo "${red}This next section will ask you for input."
echo "Recommended answers are provided here. Copy and paste this list"
echo "to someplace where you can reference it while you answer these"
echo "questions."
echo "1. Enter the current password for root - this can be the same as your"
echo "machine's root password. Enter the password at the prompt."
echo "2. Change the root password: Choose 'n'"
echo "3. Remove anonymous users: Choose 'y'"
echo "4. Disallow root login remotely: Choose 'y'"
echo "5. Remove test database and access: Choose 'y'"
echo "6. Reload privilege tables: Choose 'y'${NC}"
sudo mysql_secure_installation
sudo apt install php-mysql -y
sudo service apache2 restart
# git Config
read -p "Enter your name (may use SCA name here):" name
git config --global user.name "$name"
read -p "Enter your email address (DO NOT use webminister@axemoor.net):" email
git config --global user.email "$email"

# clone the Axemoor website repo
cd /var/www/axemoor/public_html
git clone https://github.com/Axemoor/website.git .

# clone the Axemoor help system
mkdir $HOME/help
git clone https://github.com/Cordelya/axemoor-bootstrap.git $HOME/help 
PATH=$PATH:$HOME/help/
chmod +x axemoor.sh
echo "Setup is complete. Please type "axemoor.sh" at the command prompt and
press the Enter key to access the help system"
