#!/bin/bash

echo "Installing Dependencies for Jenkins"

sudo yum -y install java-1.8.0-openjdk-devel wget firewalld python3

echo "Add Jenkins Software Repository"

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum update -y

echo "Starting Firewall Service"

sudo systemctl start firewalld
sudo systemctl enable firewalld

echo "Install Jenkins on CentOS 8"

echo "Copy User file"
cp users.groovy /usr/share/jenkins/ref/init.groovy.d/

sudo yum -y install jenkins

echo "Start Jenkins Service"

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo sed -i 's#<installStateName>NEW.*#<installStateName>RUNNING<\/installStateName>#g' /var/lib/jenkins/config.xml
sudo service jenkins restart


echo "Set Firewall to Allow Jenkins"

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

sudo firewall-cmd --reload

echo "Run and Set up Jenkins on http://your_domain:8080"

echo "Your user name is admin and password is displayed below"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

