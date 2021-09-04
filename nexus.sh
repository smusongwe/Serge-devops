#!/bin/bash
# installing java openjdk1.8
sudo yum install java-1.8.0-openjdk.x86_64 -y
# creat a dir name app and cd into into
sudo mkdir /app && cd /app
#download the latest version of nexus
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
# untar the file
sudo tar -xvf nexus.tar.gz
#rename the folder 
sudo mv nexus-*/ nexus
sudo adduser nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
#Open /app/nexus/bin/nexus.rc file
sudo echo "run_as_user=\"nexus\"" > /app/nexus/bin/nexus.rc


sudo echo "[Unit]	
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target" >>/etc/systemd/system/nexus.service

sudo chkconfig nexus on
# start the service
sudo systemctl start nexus
# start the service
sudo systemctl status nexus