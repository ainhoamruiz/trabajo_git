#!/bin/bash
# Instalación automática de Nginx
sudo apt-get update && sudo apt-get install -y nginx

# Configuración según el tipo de nodo
if [[ $(hostname) == *"lb"* ]]; then
    sudo cp nginx_lb.conf /etc/nginx/sites-available/default
else
    sudo cp nginx_frontal.conf /etc/nginx/sites-available/default
fi

#Securización (Solo puertos necesarios)
sudo ufw allow 80/tcp
sudo ufw allow 22/tcp
sudo ufw --force enable

sudo systemctl restart nginx
