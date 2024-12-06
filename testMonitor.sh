#!/bin/bash

PROCESS_NAME="test"
MONITOR_SERVER=https://test.com/monitoring/test/api
TIME_CHECK_PROCESS=60

CHECK_RUN_PROCESS=$(ps aux | grep $PROCESS_NAME | grep -v grep | awk '{print $11}')
STATUS_MONITOR_SERVER=$(curl --trace-ascii trace_file  --connect-timeout 5 -w "%{http_code}\n" -o /dev/null $MONITOR_SERVER)
MSG_MONITOR_SERVER=$(curl -X POST $MONITOR_SERVER)

    if [[ -n "$CHECK_RUN_PROCESS" ]]; then
        :
    else
        $PROCESS_NAME &
    fi

    if [[ "$STATUS_MONITOR_SERVER" -eq 200 ]]; then
        :
    else
    awk '/== Info: / {print strftime("%d.%m.%y %H:%M:%S"), $0}' trace_file | sudo tee -a /var/log/monitoring.log
    fi

    for ((i=0; i<TIME_CHECK_PROCESS; i+=5)); 
        do
            if [ -z "$CHECK_RUN_PROCESS" ]; then
                $PROCESS_NAME &
                echo "$(date +"%d.%m.%y %H:%M:%S") Failed monitoring process $PROCESS_NAME. Restart." | sudo tee -a /var/log/monitoring.log
            fi
            sleep 5
        done

    rm trace_file
