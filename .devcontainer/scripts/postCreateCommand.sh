sudo apt update
sudo sh -c "yes | apt install apache2"
sudo sh -c "yes | apt install lsyncd"

# SSIの設定追加
sudo sed -i -z 's/<Directory \/var\/www\/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride None\n\tRequire all granted\n<\/Directory>/<Directory \/var\/www\/>\n\tOptions Includes FollowSymLinks\n\tAllowOverride None\n\tRequire all granted\n\tAddtype text\/html \.txt\n\tAddOutputFilter INCLUDES \.html\n<\/Directory>/' /etc/apache2/apache2.conf

# localhostのみがアクセスできるようにする。
sudo sed -i 's/Listen 80/Listen 127.0.0.1:3000/' /etc/apache2/ports.conf
sudo sh -c "echo 'ServerName localhost' >> /etc/apache2/apache2.conf"

# serviceコマンドじゃないと起動・停止とか出来ない。
sudo service apache2 start

# ディレクトリの同期（権限周りが解決できないため、対象ソースをコピーする。）
# sudo rsync -r -v --delete /workspaces/codespaces-apache2/src /var/www/html

# リアルタイム同期（権限周りが解決できないため、対象ソースをコピーする。）
sudo lsyncd -delay 1 -direct /workspaces/codespaces-apache2/src/ /var/www/html/src