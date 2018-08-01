#!/bin/bash

#support qrcode of openresty on centos7
current_dir=$(pwd)

pre_install(){
	yum -y install libpng-devel
	#https://github.com/fukuchi/libqrencode
	#http://rpmfind.net/linux/rpm2html/search.php?query=qrencode-devel
	rpm -ivh http://ftp.riken.jp/Linux/centos/7/os/x86_64/Packages/qrencode-devel-3.4.1-3.el7.x86_64.rpm
}

install() {
	cd ${current_dir}/../src
	git clone https://github.com/orangle/lua-resty-qrencode
	cd lua-resty-qrencode 
	make && make install
}

uninstall()
{
	yum remove libpng-devel
	rpm -e qrencode-devel
	rm -rf /usr/local/openresty/lualib/qrencode.so

}


pre_install
install
