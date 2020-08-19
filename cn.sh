#!/bin/bash
cd /
#
# system env
# 
# set hostname
hostname cn.yimian.xyz
hostnamectl set-hostname cn.yimian.xyz
# 
# yum update
# 
yum -y update
yum install epel-release -y
#
# Development Tools
#
yum install -y wget git vim unzip zip openssl make gcc gcc-c++ screen rsync openssl-devel fuse fuse-devel
# git config
git config --global user.name cn.yimian.xyz
git config --global user.email i@iotcat.me
git config --global core.autocrlf input
#
# docker
#
yum -y install docker
systemctl enable docker
systemctl start docker
curl -L https://proxy.yimian.xyz/get/?url=https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
#
# nodeJS
#
# 
# firewall
# 
systemctl stop firewalld
systemctl disable firewalld
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
yum install iptables-services iptables-devel -y
systemctl start iptables
systemctl enable iptables
iptables -F
iptables -P OUTPUT ACCEPT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
service iptables save
systemctl restart iptables
#
# config
#
cd /usr/etc/
echo Ready~~
#############################
#  Ushio Env Ini Finished           
#############################
# 
# Email Notice
curl "https://api.yimian.xyz/mail/?to=i@iotcat.me&subject=$(hostname) Ushio Env ini finished&body=ini finished!!"
#
# system reboot 
#reboot
