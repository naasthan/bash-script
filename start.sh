#!/bin/bash

GREATE_MKDIR=usr/local/bin

if [[ -d $GREATE_MKDIR ]]; then
  :
else
  sudo mkdir -p $GREATE_MKDIR
fi

sudo cp monitoring.log /var/log/
sudo cp testMonitor.sh /usr/lib/systemd/system
sudo cp unitMonitorTest.service /etc/systemd/system/

sudo chmod +x /usr/lib/systemd/system/testMonitor.sh

sudo systemctl enable unitMonitorTest.service
sudo systemctl start unitMonitorTest.service

exit 0