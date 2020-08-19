#!/bin/bash

# =================================== #
# Axemoor Bootstrap Initialize Script #
# =================================== #

# First, some housekeeping
echo "Beginning software update"
sudo apt-get update
sudo apt-get upgrade -y
echo "Software update complete"

sudo apt-get install -y apache2

echo "Done installing Apache2"
echo "Enable and start SSH"
sudo systemctl enable ssh
sudo systemctl start ssh
echo "Done with SSH"

# Apache Config
echo "Apache config starting now"

# Check for /var/www. If it isn't found, we can't continue.
if [ ! -d "/var/www" ];
  then echo "Apache didn't install correctly. Aborting." && exit
  else echo "Apache installed correctly. Continuing.."
fi

# Check for /var/www/axemoor. If it doesn't exist, make it.
if [ ! -d "/var/www/axemoor" ];
then
sudo mkdir /var/www/axemoor/public_html -p
sudo chown -R $USER:$USER /var/www/axemoor/public_html
sudo chmod -R 755 /var/www
fi
echo "Attempting to restart Apache. Hang on!"

sudo systemctl restart apache2 --no-pager
sudo systemctl status apache2 --no-pager
echo "Done configuring Apache. Now installing additional software."
sudo apt-get install -y php
sudo apt-get install -y git
sudo apt-get install -y mysql-server
sudo apt-get install -y php-mysql
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
PATH=$PATH:$HOME/help/
chmod +x $HOME/help/axemoor.sh
echo "Setup is complete. System reboot required.

Once your system reboot is complete, you can test this installation 
by visiting http://axemoor.net using your local browser. 

Your /etc/hosts file has been modified to direct axemoor.net to 
the local host. Changes you make to files in 

/var/www/axemoor/public_html 

will appear on refresh(F5). 

Press enter to continue." e
sudo reboot
