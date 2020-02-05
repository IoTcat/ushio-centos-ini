#!/bin/bash
#firewall
systemctl stop firewalld
systemctl disable firewalld
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
yum install iptables-services iptables-devel -y
systemctl start iptables
systemctl enable ipdables
