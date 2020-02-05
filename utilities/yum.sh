#!/bin/bash
# yum update
yum -y update
yum install epel-release -y
yum groupinstall "Development Tools" -y
# system tools
yum install -y wget git vim unzip zip bzip2
