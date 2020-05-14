#!/bin/bash
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
cd
sudo git clone https://github.com/WiringPi/WiringPi.git
cd WiringPi
sudo git pull origin
./build
echo ""
echo "Install GumCP"
echo ""
cd /tmp
sudo git clone https://github.com/crossplatformdev/GumCP.git
sudo cp -r /tmp/GumCP /usr/share/
rm /tmp/GumCP
sudo cp /usr/share/GumCP/007-GumCP.conf /etc/apache2/sites-available/007-GumCP.conf
ln -s /etc/apache2/sites-available/007-GumCP.conf /etc/apache2/sites-enabled/007-GumCP.conf 
echo ""
echo "Setting Password for GumCP (you have to write)"
echo ""
sudo htpasswd -c /usr/local/apache/passwd/passwords gumcp
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
