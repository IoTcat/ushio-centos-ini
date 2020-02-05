#!/bin/bash
#firewall
systemctl stop firewalld
systemctl disable firewalld
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
yum install iptables-services iptables-devel -y
systemctl start iptables
systemctl enable iptables
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
service iptables save
