#!/usr/bin/env bash

sudo apt-get update

# # ========================================
# # install apache
#
# sudo apt-get install -y apache2
#
# sudo a2enmod rewrite
# sudo service apache2 restart

# ========================================
# install java

sudo apt-get install -y default-jdk

# ========================================
# install tomcat
# @see https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-16-04

sudo groupadd tomcat
# sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
sudo usermod -a -G tomcat vagrant
curl -O http://mirror.vorboss.net/apache/tomcat/tomcat-8/v8.5.34/bin/apache-tomcat-8.5.34.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf

sudo chown -R tomcat webapps/ work/ temp/ logs/

# The output of the end column is the path to java, but we'll attach /jre to this
sudo update-java-alternatives -l

# Use this for JAVA_HOME=path/jre in environments.
# sudo vim /etc/systemd/system/tomcat.service
sudo cp /vagrant/tomcat.service /etc/systemd/system/

# Next, reload the systemd daemon so that it knows about our service file:
sudo systemctl daemon-reload

# Start the Tomcat service by typing:
sudo systemctl start tomcat

# Check tomcat is running OK
#sudo systemctl status tomcat

# Now that the Tomcat service is started, we can test to make sure the default page is available.
# Before we do that, we need to adjust the firewall to allow our requests to get to the service. If you followed the prerequisites, you will have a ufw firewall enabled currently.
# Tomcat uses port 8080 to accept conventional requests. Allow traffic to that port by typing:
sudo ufw allow 8080

# If you were able to successfully accessed Tomcat, now is a good time to enable
# the service file so that Tomcat automatically starts at boot:
sudo systemctl enable tomcat

# You will want to add a user who can access the manager-gui and admin-gui (web
# apps that come with Tomcat). You can do so by defining a user, similar to the
# example below, between the tomcat-users tags. Be sure to change the username
# and password to something secure
# e.g. <user username="admin" password="password" roles="manager-gui,admin-gui"/>
# TODO sudo vim /opt/tomcat/conf/tomcat-users.xml

# TODO see context.xml section on tutorial page

# TODO sudo systemctl restart tomcat

# TODO Step 8: Access the Web Interface
