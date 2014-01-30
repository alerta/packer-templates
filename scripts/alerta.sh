#!/bin/sh -e

# Install required dependencies
sudo apt-get install -y git python-setuptools python-pip build-essential python-dev
sudo apt-get install -y mongodb-server rabbitmq-server apache2 libapache2-mod-wsgi

# Configure MongoDB for development environment
grep -q smallfiles /etc/mongodb.conf || echo "smallfiles = true" | sudo tee -a /etc/mongodb.conf
sudo service mongodb restart

# Configure RabbitMQ to enable STOMP and declare default exchange
sudo /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management
sudo /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_stomp
sudo service rabbitmq-server restart
wget -qO /var/tmp/rabbitmqadmin http://guest:guest@localhost:55672/cli/rabbitmqadmin && chmod +x /var/tmp/rabbitmqadmin
/var/tmp/rabbitmqadmin declare exchange name=alerts type=fanout

# Install and configure Alerta
sudo pip install alerta
sudo mkdir -p /etc/alerta
sudo wget -qO /etc/alerta/alerta.conf https://raw.github.com/alerta/packer-templates/master/files/alerta.conf
sudo wget -qO /etc/init/alerta.conf https://raw.github.com/alerta/packer-templates/master/files/upstart-alerta.conf
sudo initctl reload-configuration alerta
sudo service alerta restart

# Configure Apache web server
sudo mkdir -p /var/www/alerta
sudo wget -qO /var/www/alerta/alerta-api.wsgi https://raw.github.com/alerta/packer-templates/master/files/alerta-api.wsgi
sudo wget -qO /etc/apache2/conf.d/alerta-api.conf https://raw.github.com/alerta/packer-templates/master/files/httpd-alerta-api.conf
sudo wget -qO /var/www/alerta/alerta-dashboard.wsgi https://raw.github.com/alerta/packer-templates/master/files/alerta-dashboard.wsgi
sudo wget -qO /etc/apache2/conf.d/alerta-dashboard.conf https://raw.github.com/alerta/packer-templates/master/files/httpd-alerta-dashboard.conf
PYTHON_ROOT_DIR=`pip show alerta | awk '/Location/ { print $2 } '`
sudo sed -i "s#@STATIC@#$PYTHON_ROOT_DIR#" /etc/apache2/conf.d/alerta-dashboard.conf
sudo chmod 0775 /var/log/alerta && sudo chgrp www-data /var/log/alerta
sudo service apache2 restart

# Generate test alerts
wget -qO /var/tmp/create-alerts.sh https://raw.github.com/alerta/packer-templates/master/files/create-alerts.sh
chmod +x /var/tmp/create-alerts.sh && /var/tmp/create-alerts.sh

