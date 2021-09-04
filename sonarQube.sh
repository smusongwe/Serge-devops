#!/bin/bash
sudo yum update -y

#installing Java 1.8.0
sudo yum install java-1.8.0 -y

# add the sonar repo
sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
#installing sonar
sudo yum install sonar -y

# start sonar on system boot
sudo chkconfig sonar on
# staring the sonarm service
sudo service sonar start