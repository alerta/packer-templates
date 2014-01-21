#!/bin/sh -x

set -e

echo "Waiting for network interfaces..."
sleep 30

# Update and upgrade standard packages
sudo apt-get clean
sudo apt-get update
#sudo apt-get upgrade

# Install required dependencies
sudo apt-get -y -q install wget git python-setuptools python-pip
sudo apt-get -y -q install build-essential python-dev

# Install and Configure RabbitMQ, MongoDB, Apache web server and Java
sudo apt-get -y -q install rabbitmq-server
sudo /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management
sudo /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_stomp
sudo service rabbitmq-server restart
cd /var/tmp
wget http://guest:guest@localhost:55672/cli/rabbitmqadmin && chmod +x rabbitmqadmin
./rabbitmqadmin declare exchange name=alerts type=fanout

# Install and Configure MongoDB
sudo apt-get -y -q install mongodb-server
# create 'alerta' user

# Install and Configure Apache web server
sudo apt-get -y -q install apache2 libapache2-mod-wsgi

# Install and Configure Alerta
sudo pip install alerta
# cd /var/tmp
# git clone https://github.com/guardian/alerta.git
# cd alerta
# pip install -r requirements.txt
# python setup.py install

# Install and Configure Ganglia
sudo apt-get -y -q install ganglia-monitor gmetad

# Install and Configure Riemann
sudo apt-get -y -q install default-jre
cd /var/tmp
wget http://aphyr.com/riemann/riemann_0.2.4_all.deb
sudo dpkg -i /var/tmp/riemann_0.2.4_all.deb

