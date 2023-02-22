#!/bin/bash

apt-get update
apt-get install nginx -y
systemctl restart nginx
apt-get install docker.io -y
rm /var/www/html/*
echo "I am terraform generated script" >> /var/www/html/index.html