cd pcre-8.42
./configure
make
cd -

cd nginx-1.15.9 
./configure --with-pcre=../pcre-8.42/ --prefix=/home/pi/pktcapve/nginx/rpi3/
make && make install
cd -
