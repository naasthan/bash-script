# bash script

## About

bash script for monitoring the test process in a Linux environment

## Development
`chmod +x start.sh`                                   : rights to run the script
`./start.sh`                                          : start script
`journalctl -u unitMonitorTest.service`               : view systemd process unitMonitorTest.service log
`sudo rm /etc/systemd/system/unitMonitorTest.service` : deleting a file unitMonitorTest.service
`sudo rm /var/log/monitoring.log`                     : deleting a file monitoring.log
`sudo rm /usr/lib/systemd/system/testMonitor.sh`      : deleting a file testMonitor.sh