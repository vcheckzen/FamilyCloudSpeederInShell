#!/bin/sh

# copyright logi all rights reserved.
source /etc/storage/script/init.sh

while [[ ! -f /opt/bin/opkg ]]
do
   sleep 60
   logger -t 'CloudDisk' 'No opt, sleep 60s.'
done

logger -t 'CloudDisk' 'Install requirements ...'
opkg update && opkg install \
coreutils-nohup libreadline libcurl libopenssl \
bash curl wget openssl-util ca-certificates ca-bundle
logger -t 'CloudDisk' 'Requirements installed.'

if [[ "`ps | grep speedup | grep -v grep`" == "" ]];
then
    nohup /opt/bin/bash /etc/storage/CloudDisk/speedup.sh > /dev/null 2>&1 &
    logger -t 'CloudDisk' 'Started.'
fi