#/bin/bash
export PATH=$PATH:~/.local/bin
sudo apt-get install -y python3-pip
source bin/activate
python3 -m pip install Django==2.0 --user
python3 -m pip install gunicorn --user
sudo pktcap/settcpdumpperm.sh

