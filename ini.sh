#/bin/bash
cd ~
# change hostname
echo -n  "please enter hostname ->"
read  hostname
hostnamectl --static set-hostname $hostname
# yum update
yun -y update
yum install epel-release -y
# system tools
yum install -y wget git vim unzip
# git config
git config --global user.name $hostname
git config --global user.email git@$hostname.yimian.xyz
# gcc
yum install -y gcc gcc-c++ gdb openssl make
# php
rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php72w php72w-cli php72w-common php72w-devel php72w-embedded php72w-fpm php72w-gd php72w-mbstring php72w-mysqlnd php72w-opcache php72w-pdo php72w-xml
systemctl start php-fpm
systemctl enable php-fpm
# go
yum install -y golang
# nodejs

# python
yum install https://centos7.iuscommunity.org/ius-release.rpm -y
yum install python36u -y
yum install python36u-devel -y
ln -s /bin/python3.6 /bin/python3
yum install python36u-pip -y
ln -s /bin/pip3.6 /bin/pip3
yum install -y python-pip
pip install --upgrade pip
pip3 install --upgrade pip
# docker
yum -y install docker
systemctl enable docker
systemctl start docker
pip install --upgrade backports.ssl_match_hostname
pip install docker-compose
# fin
echo -n "Please edit the hostname in /etc/hosts manually!!"
