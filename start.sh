#!/bin/bash

img=$1
name=$2
num=$3
ip=$4

if [ "$name" == '' ] || [ "$num" == '' ]
then
    echo "Need parameters!"
    exit 0
fi

if [ "$ip" == '' ]
then
    ip="51"
fi

if [ "$img" == '' ]
then
    img="images:alpine/3.18/default"
fi

for i in $(seq $num)
do
    ip_new=$((ip+i-1))
    #echo "$i $ip_new $name"
    lxc launch $img $name$i --device eth0,ipv4.address=10.246.135.${ip_new}
    echo "10.246.135.${ip_new} $name$i" | sudo tee -a /etc/hosts
done

sudo systemctl restart dnsmasq