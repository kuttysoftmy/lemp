#!/bin/bash

# Add Nginx repository
echo "deb http://nginx.org/packages/mainline/ubuntu/ $(lsb_release -cs) nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

# Add Nginx signing key
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -

# Update package list
sudo apt-get update

# Install Nginx
sudo apt-get install nginx -y

# Install MySQL
sudo apt-get install mysql-server-5.7 mysql-client-5.7 -y

# Install PHP and required extensions
sudo apt-get install php7.2-fpm php7.2-mysql php7.2-curl php7.2-json php7.2-cgi php7.2-cli php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-gd php7.2-xml php7.2-zip -y

# Install phpMyAdmin
sudo apt-get install phpmyadmin -y

# Download and install ionCube Loader
curl -fsSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz | tar xzf -
sudo mv ioncube/ioncube_loader_lin_7.2.so /usr/lib/php/20170718/
echo "zend_extension = /usr/lib/php/20170718/ioncube_loader_lin_7.2.so" | sudo tee /etc/php/7.2/fpm/conf.d/00-ioncube-loader.ini
echo "zend_extension = /usr/lib/php/20170718/ioncube_loader_lin_7.2.so" | sudo tee /etc/php/7.2/cli/conf.d/00-ioncube-loader.ini

# Restart PHP-FPM and Nginx
sudo systemctl restart php7.2-fpm nginx
