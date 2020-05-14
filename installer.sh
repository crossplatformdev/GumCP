#!/bin/bash
DIR=pwd
if [ $1 eq "uninstall" ]; then
    echo ""
    echo "Performing uninstall"
    echo ""    
    apt purge git apache2 mod-php php-sqlite3 php-ssh2 php libapache2-mod-php
    rm -fr /usr/share/GumCP
    rm /var/www/passwords
    rm /etc/apache2/sites-enabled/007-GumCP.conf
    echo "Uninstall complete!"
    exit 0
fi
if [ $1 eq "clean" ]; then
    echo ""
    echo "Performing clean install"
    echo ""    
    apt purge git apache2 mod-php php-sqlite3 php-ssh2 php libapache2-mod-php
    rm -fr /usr/share/GumCP   
    rm /var/www/passwords
    rm /etc/apache2/sites-enabled/007-GumCP.conf
fi
echo ""
echo "GumCP installer"
echo ""
sudo apt-get update -y
echo ""
echo "Install git"
echo ""
sudo apt-get install git -y
echo ""
echo "Install apache2"
echo ""
sudo apt-get install apache2 -y
echo ""
echo "Install mod-php"
echo ""
sudo apt-get install php libapache2-mod-php -y
echo ""
echo "Install php-sqlite3"
echo ""
sudo apt-get install php-sqlite3
echo ""
echo "Install php-ssh2"
echo ""
sudo apt-get install php-ssh2
echo ""
echo "Install wiringPI"
echo ""
cd /tmp
sudo git clone https://github.com/WiringPi/WiringPi.git
cd WiringPi
sudo git pull origin
./build
cd ..
rm -fr /tmp/WiringPi
echo ""
echo "Install GumCP"
echo ""
sudo git clone https://github.com/crossplatformdev/GumCP.git
sudo cp -r /tmp/GumCP /usr/share/
rm /tmp/GumCP
sudo cp /usr/share/GumCP/007-GumCP.conf /etc/apache2/sites-available/007-GumCP.conf
ln -s /etc/apache2/sites-available/007-GumCP.conf /etc/apache2/sites-enabled/007-GumCP.conf 
ln -s /usr/share/GumCP/ /var/www/GumCP/
echo ""
echo "Setting Password for GumCP (you have to write)"
echo ""
sudo htpasswd -c /var/www/passwords gumcp
echo ""
echo "Restart apache service"
echo ""
sudo service apache2 restart
sudo rm -f /var/www/html/GumCP/installer.sh
sudo chmod 777 /var/www/html/GumCP/include/config.php
echo ""
echo "Done"
echo ""
echo ""
echo "GumCP should be installed at:"
echo ""
IP="$(hostname -I | cut -d' ' -f1)"
echo "http://${IP}/GumCP/"
echo ""
echo "If you cant access it, then something went wrong, you can open an issue at github: https://github.com/crossplatformdev/GumCP/issues"
echo ""
cd $DIR
