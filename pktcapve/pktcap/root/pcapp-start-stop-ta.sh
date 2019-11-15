#!/bin/bash

if [ -f /tmp/pcapp.cmd.stop ];then

  if [ -f /ta/wrapper.sh ];then
     if ps -auxww | grep -q [t]raffic-analysis; then
       echo "#* * * * * root bash /ta/scripts/run.sh > /tmp/run.log" > /etc/cron.d/cron-traffic-analysis
       bash /ta/wrapper.sh -k
     fi
  fi
else
  if ! ps -auxww | grep -q [t]raffic-analysis; then
     echo "* * * * * root bash /ta/scripts/run.sh > /tmp/run.log" > /etc/cron.d/cron-traffic-analysis
  fi
fi


