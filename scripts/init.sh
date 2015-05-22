#!/usr/bin/env bash 

# sudo apt-get update
# sudo apt-get install openjdk-7-jdk

WORK_DIR=/public/`hostname -s`

if [ ! -d $WORK_DIR ]; then
  sudo mkdir -p $WORK_DIR
  sudo chown `whoami` $WORK_DIR 
fi

