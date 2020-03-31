#!/bin/bash
cd /
#
# system env
# 
# set hostname
hostname $1
hostnamectl set-hostname $1
#
# set USHIO_VERSION env var
export USHIO_VERSION="$3"
echo export USHIO_VERSION="$3">>/etc/profile
#
# active rc.local
#
#chmod +x /etc/rc.d/rc.local
# 
# yum update
# 
yum -y update
yum install epel-release -y
#
# Development Tools
#
yum install -y wget git vim unzip zip openssl make gcc gcc-c++ screen fuse fuse-devel
# git config
git config --global user.name $1
git config --global user.email git@$1
git config credential.helper store
git config --global core.autocrlf input
#
# docker
#
yum -y install docker
systemctl enable docker
systemctl start docker
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
wget -P /etc/systemd/system https://onedrive.yimian.xyz/config/systemd/ushio.service
chmod +x /etc/systemd/system/ushio.service
sed -i 's/$HOSTNAME/'$1'/g' /etc/systemd/system/ushio.service
systemctl daemon-reload
systemctl enable ushio
# 
# firewall
# 
systemctl stop firewalld
systemctl disable firewalld
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
yum install iptables-services iptables-devel -y
systemctl start iptables
systemctl enable ipdables
iptables -A OUTPUT -j ACCEPT
iptables -A INPUT -j REJECT
iptables -A FORWARD -j REJECT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
service iptables save
service iptables restart
#
# onedrive
#
curl https://rclone.org/install.sh | sudo bash
wget -P /root/.config/rclone/ https://onedrive.yimian.xyz/config/rclone/rclone.conf.aes
openssl enc -aes-128-cbc -in /root/.config/rclone/rclone.conf.aes -out /root/.config/rclone/rclone.conf -pass pass:$2 -d
nohup rclone mount onedrive:ushio/$3 /mnt --allow-other --allow-non-empty --vfs-cache-mode writes &
wget -P /etc/systemd/system https://onedrive.yimian.xyz/config/systemd/rclone.service
chmod +x /etc/systemd/system/rclone.service
sed -i 's/$USHIO_VERSION/'$3'/g' /etc/systemd/system/rclone.service
systemctl daemon-reload
systemctl enable rclone
systemctl start rclone
#
# config
#
ln -s /mnt/config/vim/.vimrc ~/.vimrc
ln -s /mnt/config/git/.git-credentials ~/.git-credentials
#############################
#  Ushio Env Ini Finished           
#############################
# 
# Email Notice
curl "https://api.yimian.xyz/mail/?to=i@iotcat.me&subject=$1 Ushio Env ini finished&body=ini finished!!"
#
# system reboot 
reboot
