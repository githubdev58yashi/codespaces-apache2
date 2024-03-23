echo ======postCreateCommand=====
sudo sh -c \"yes | apt install apache2\"
sudo rsync -r -v --delete /workspaces/codespaces-apache2/src /var/www/html
sudo sed -e 's/Listen 80/Listen 127.0.0.1:3000/' -i /etc/apache2/ports.conf
sudo sed -e '$a ServerName localhost' -i /etc/apache2/apache2.conf
sudo service apache2 start