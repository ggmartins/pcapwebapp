# pcapwebapp
Simple Django WebApp to command TCPDUMP process in Linux

#### Pre-requisites
linux nginx mod_wsgi python3 django bash tcpdump pip3 virtualenv

#### Installation and Running:

1. Install

      $pip3 install virtualenv django
      
2. Activate virtual environment

      $source pktcapve/bin/activate

4. Assign local network IPs in nginx configuration file is required.

      $vim pktcapve/nginx/<platform>/conf/nginx.conf
      
3. Run nginx
      
      $cd pktcapve/nginx; bash run.sh

TODO:
- support for latest plarforms
- packaging
- new features
