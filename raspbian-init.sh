#!/bin/bash

# =================================== #
# Axemoor Bootstrap Initialize Script #
# =================================== #
# Raspbian Edition

# First, some housekeeping
echo "Beginning software update"
sudo apt-get update
sudo apt-get upgrade -y
echo "Software update complete"

# install apache2
sudo apt-get install -y apache2 
echo "Done with Apache2"
echo "Enable & Start SSH"
sudo systemctl enable ssh
sudo systemctl start ssh
echo "Done with SSH"

# Apache Config
echo "Apache config starting now"

# Check for /var/www. If not found, apache2 install has failed 
# and we need to abort the install.
if [ ! -d "/var/www" ];
  then echo "Apache didn't install correctly. Aborting." && exit
fi

# Check for /var/www/axemoor. If it doesn't exist, make it
if [ ! -d "/var/www/axemoor" ];
  then
  sudo mkdir /var/www/axemoor/public_html -p
  sudo chown -R $USER:$USER /var/www/axemoor/public_html
  sudo chmod -R 755 /var/www

echo "Attempting to restart Apache. Hang on."
sudo systemctl restart apache2 --no-pager
echo "Apache status is"
sudo systemctl status apache2 --no-pager
echo "Done configuring Apache. Now installing additional software."

# install php, libcache2-mod-php, git, systemctl, and mariadb-server
sudo apt-get install -y php
sudo apt-get install -y libcache2-mod-php
sudo apt-get install -y git
sudo apt-get install -y systemctl
sudo apt-get install -y mariadb-server

echo "$(tput setaf 3)This next section will ask you for input.
Recommended answers are provided here. Copy and paste this list
to someplace where you can reference it while you answer these
questions.
1. Enter the current password for root - this can be the same as your
machine's root password. Enter the password at the prompt.
2. Change the root password: Choose 'n'
3. Remove anonymous users: Choose 'y'
4. Disallow root login remotely: Choose 'y'
5. Remove test database and access: Choose 'y'
6. Reload privilege tables: Choose 'y' $(tput setaf 0)"

sudo mysql_secure_installation
sudo apt-get install php-mysql -y
sudo service apache2 restart

# git Config
read -p "Enter your name (may use SCA name here):" name
git config --global user.name "$name"
read -p "Enter your email address (DO NOT use webminister@axemoor.net):" email
git config --global user.email "$email"

# clone the Axemoor website repo
git clone https://github.com/Axemoor/website.git /var/www/axemoor/public_html

# clone the Axemoor help system
mkdir $HOME/help
git clone https://github.com/Cordelya/axemoor-bootstrap.git $HOME/help 

# copy the website configuration file to the apache2 sites-available dir
sudo cp $HOME/help/axemoor.net.conf
/etc/apache2/sites-available/axemoor.net.conf

# enable axemoor.net and disable the default site
sudo a2ensite axemoor.net  
sudo a2dissite 000-default

#reload the webserver
systemctl reload apache2    

# make axemoor.sh executable
PATH=$PATH:$HOME/help/
chmod +x $HOME/help/axemoor.sh
echo "Setup is complete. Please return to the setup instructions for the next
steps"
