#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`
if [[ $ether = "" ]]; then
        ether=eth0
fi

#vps="zvur";
vps="aneka";

#if [[ $vps = "zvur" ]]; then
	#source="http://"
#else
	source="https://raw.githubusercontent.com/mulzs/new"
#fi

# go to root
cd

# check registered ip
wget -q -O IPcarding $source/debian7/IPcarding.txt
if ! grep -w -q $MYIP IPcarding; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "zvur" ]]; then
		echo "Hubungi: editor MOHD-FAZREN / MuLuu09"
	else
		echo "Hubungi: editor MOHD-FAZREN / MuLuu09"
	fi
	rm -f /root/IPcarding
	rm /root/IPcarding
	exit
fi

echo "##############################################################

OPTIONS:      -h = untuk mengetahui command command apa aja yang ada diuniscan
              -u = untuk memasukkan url
              -f = untuk multy scan url
              -b = untuk membuat uniscan bekerja dibackground atau latar belakang operating system
              -q = untuk mengecheck directory yang ada di website tersebut,disini kita bisa mengetahui file file yang tersembunyi pada website tersebut
              -w = untuk mengecheck file yang ada di website tersebut
              -e = untuk mengecheck apakah ada robots.txt dan sitemap.xml
              -d = untuk mencari kelemahan website dengan exploit exploit yang ada diuniscan tersebut
              -s = hampir sama dengan -d
              -r = untuk strees testing,stress testing sudah dijelakan di postingan sebelumnya
              -i = <dork> Bing search
              -o = <dork> Google search
              -g = Web fingerprint
              -j = Server fingerprint

contoh dork:  inurl:shop.php?do=part&id= 
              inurl:shop_category.php?id= 
              inurl:shopping.php?id= 
              inurl:shopping.php?id= 
              inurl:view_product.php?id= 
              inurl:view_product.php?id= 
              irbeautina/product_detail.asp?product_id= 
              irbeautina/product_detail.php?product_id= 
              item.asp?eid= 
              item.asp?id= 
              item.asp?iid= 
              item.asp?item_id= 
	      
contoh penulisan: -u http://www.example.com/ -qweds
                  -f sites.txt -bqweds
                  -i uniscan
                  -i "ip:xxx.xxx.xxx.xxx"
                  -o "dork_yg_mau_dicari"
                  -u https://www.example.com/ -r"
		  echo ""
 echo "           KELUAR tekan ctrl + z "
 echo ""
# web vuln
cd /root
read -p "Masukkan OPTION seperti (contoh penulisan): " webscaner
cd uniscan6.2
./uniscan.pl $webscaner
echo ""
cd
web-vuln.sh
cd /root
