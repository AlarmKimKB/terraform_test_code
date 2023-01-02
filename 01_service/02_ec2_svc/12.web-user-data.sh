#!/bin/bash
yum update -y
timedatectl set-timezone Asia/Seoul

systemctl disable rpcbind.service --now
systemctl disable rpcbind.socket --now
systemctl disable postfix --now

echo "HISTTIMEFORMAT=\"[%Y-%m-%d %H:%M:%S] \"" >> /etc/profile
source /etc/profile

yum install httpd -y
systemctl enable httpd --now
cat > /var/www/html/index.html << EOT 
Hello, World.

EOT


hostnamectl set-hostname web