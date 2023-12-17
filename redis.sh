#!/bin/bash

img="redis-alpine"
name="redis"
num=$1
ip=$2

bash start.sh $img $name $num $ip

cmd="echo 'yes' | redis-cli -h $(lxc config device get ${name}1 eth0 ipv4.address) -p 6379 --cluster create "

for i in $(seq $num)
do
    cmd+="$(lxc config device get $name$i eth0 ipv4.address):6379 "
done

cmd+="--cluster-replicas 1"

sleep 2

echo $cmd
bash -c "$cmd"