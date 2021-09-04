#!/bin/bash
sudo yum update -y 
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo amazon-linux-extras install epel -y
sudo yum install epel-release -y
# installing java
sudo yum install java-1.8* -y
# starting the jenkins service
sudo yum install jenkins -y

sudo systemctl start jenkins
sudo systemctl status jenkins
# starting the service on boot 
sudo systemctl enable jenkins

# Installing git
sudo yum install git -y

# installing apache-maven
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
sudo cat /var/lib/jenkins/secrets/initialAdminPassword