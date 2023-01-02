#!/bin/bash
yum update -y
timedatectl set-timezone Asia/Seoul

systemctl disable rpcbind.service --now
systemctl disable rpcbind.socket --now
systemctl disable postfix --now

echo "HISTTIMEFORMAT=\"[%Y-%m-%d %H:%M:%S] \"" >> /etc/profile
source /etc/profile

hostnamectl set-hostname bastion