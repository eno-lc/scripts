#!/bin/bash

PATHS="/"
HOSTNAME=$(hostname)
CRITICAL=98
WARNING=90
EMAIL=enishalilajjj@gmail.com
mkdir -p /var/log/cputilhist
LOGFILE=/var/log/cputilhist/cpusage-`date +%h%d%y`.log

touch $LOGFILE

for path in $PATHS
do
    CPULOAD=`top -b -n 2 -d1 | grep "Cpu(s)" | tail -n1 | awk '{print $2}' | awk -F . '{print $1}'`
if [ -n "$WARNING" -a -n "$CRITICAL" ]; then
if [ "$CPULOAD" -ge "$WARNING" -a "$CPULOAD" -lt "$CRITICAL" ]; then
echo "`date "+%F%H:%M:%S"` WARNING  - $CPULOAD on host $HOSTNAME" >> $LOGFILE
echo "Warning CPU LOAD $CPULOAD host is $HOSTNAME" | mail -s "CPU LOAD is Warning" $EMAIL
exit 1
elif [ "$CPULOAD" -ge "$CRITICAL" ]; then
echo "`date "+%F%H:%M:%S"` CRITICAL - $CPULOAD on host $HOSTNAME" >> $LOGFILE
echo "Critical CPU LOAD $CPULOAD host is $HOSTNAME" | mail -s "CPU LOAD is CRITICAL" $EMAIL
exit 2
else
echo "`date "+%F%H:%M:%S"` OK - $CPULOAD on $HOSTNAME" >> $LOGFILE
echo "Normal CPU LOAD $CPULOAD host is $HOSTNAME" | mail -s "CPU LOAD is NORMAL" $EMAIL
exit 0
fi
fi
done

