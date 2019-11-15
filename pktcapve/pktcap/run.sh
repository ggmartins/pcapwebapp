#!/bin/bash

#iface=eth0
#/sbin/ifconfig eth1 >/dev/null 2>&1
#if [ $? -eq 0 ]; then
#  iface=eth1
#fi

export PATH=$PATH:~/.local/bin
#source ./setpath.sh
source ../bin/activate
#ipaddr=$(/sbin/ifconfig $iface | grep -oE "inet addr\:[^ ]*" | sed 's/inet addr://g')
killall -s 2 gunicorn >/dev/null 2>&1
sleep 1
echo "Running gunicorn on $ipaddr..."
#gunicorn --bind $ipaddr:8001 wsgi >run.log 2>&1 &
gunicorn --bind 127.0.0.1:8001 wsgi >run.log 2>&1 &
ps -auxww | grep [g]unicorn
