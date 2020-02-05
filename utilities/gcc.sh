#!/bin/bash
yum install -y openssl make
cd /usr/local/src/
wget https://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.gz
tar -zxvf gcc-9.2.0.tar.gz
mv gcc-9.2.0.tar.gz gcc
cd gcc
./contrib/download_prerequisites
../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
make
make install
cd ..
rm -rf gcc-9.2.0.tar.gz
