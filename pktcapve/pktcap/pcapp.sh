#!/bin/bash

start() {

iface=eth0
/sbin/ifconfig eth1 >/dev/null 2>&1
if [ $? -eq 0 ]; then
  iface=eth1
fi

mkdir -p /home/pi/tmp/pcap/tmp/
mkdir -p /home/pi/tmp/pcap/files/

id=unknown

if [ -f /etc/salt/minion_id ]; then
  id=$(cat /etc/salt/minion_id)
fi

date=$(date +%Y%m%d_%H%M%S)

#echo "Using interface: $iface on $id"

if [ ! -f /usr/sbin/tcpdump ];then
  echo "tcpdump not installed"
  exit 1
fi

touch /tmp/pcapp.cmd.stop

pcapdata=$(echo "/home/pi/tmp/pcap/tmp/$id-$date-data.pcap")
pcapdns=$(echo "/home/pi/tmp/pcap/tmp/$id-$date-dns.pcap")

/usr/sbin/tcpdump -i $iface -s100 -f not port 22 -w $pcapdata >/dev/null 2>&1 &
/usr/sbin/tcpdump -i $iface -s0 -f port 53 -w $pcapdns >/dev/null 2>&1 &

status

} #start

stop(){

  if [ -f /tmp/pcapp.cmd.stop ];then
    rm -f /tmp/pcapp.cmd.stop
  fi

  killall -s 2 tcpdump 2>/dev/null
  if [ $? -ne 0 ]; then
    echo "WARNING: not running"
    exit 0
  fi
  sleep 1
  echo "ok"
  mv /home/pi/tmp/pcap/tmp/*.pcap /home/pi/tmp/pcap/files/ 2>/dev/null
}

#reload(){
#}

status(){
  if ps -aux | grep -q "[t]cpdump" >/dev/null 2>&1; then
    echo running
  else
    echo stopped
  fi
}

scan(){
  l=$(ls /home/pi/tmp/pcap/files/*.pcap 2>/dev/null)
  if [ $? -ne 0 ]; then
    exit 0
  fi
  for f in $(ls /home/pi/tmp/pcap/files/*.pcap); do
    basename $f
  done
}

case "$1" in
        start)
                start 
                ;;
        stop)
                stop 
                ;;
        scan)
                scan
                ;;
        #reload)
        #        reload
	#	;;
        status)
                status
                ;;
        *)
                #echo $"Usage: $0 {start|stop|restart|reload|status}" 
                echo $"Usage: $0 {start|stop|status}" 
esac

