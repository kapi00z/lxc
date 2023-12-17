#!/bin/bash

name=$1

if [ "$name" == '' ]
then
    echo "No name provided"
    exit 0
fi

list=( $(lxc list -f compact $name | tail -n +2 | awk '{print $1}') )

if [ ${#list[@]} == 0 ]
then
    echo "No containers found!"
    exit 0
else
    for cont in ${list[@]}
    do
        lxc delete --force $cont
    done
    sudo sed -i "/$name/d" /etc/hosts
    sudo systemctl restart dnsmasq
fi