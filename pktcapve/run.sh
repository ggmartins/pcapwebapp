#!/bin/bash

export PATH=$PATH:~/.local/bin
source bin/activate
cd pktcap
./run.sh
cd -
cd ./nginx/
./run.sh
cd -
