#!/bin/sh

killall -s 2 nginx >/dev/null 2>&1
sleep 1
if uname -a | grep -q odroid; then
  /sbin/ifconfig eth1 >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo odc2
    cd odc2;./sbin/nginx
  else
    echo mirr
    cd mirr;./sbin/nginx -p $PWD
  fi
else
echo rpi3
cd rpi3;./sbin/nginx
fi
ps -auxww | grep "[n]ginx"
