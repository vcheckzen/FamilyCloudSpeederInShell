#!/bin/bash

base_dir=`dirname $0`
source "$base_dir/utils.sh"
config="$base_dir/config.json"


session_key=`getSingleJsonValue "$config" "session_key"`
session_secret=`getSingleJsonValue "$config" "session_secret"`
method=`getSingleJsonValue "$config" "method"`
rate=`getSingleJsonValue "$config" "rate"`
UA=`getSingleJsonValue "$config" "User-Agent"`
prodCode=`getSingleJsonValue "$config" "prodCode"`
version=`getSingleJsonValue "$config" "version"`
channelId=`getSingleJsonValue "$config" "channelId"`
extra_header="User-Agent:$UA"


ACCESS_URL="/family/qos/startQos.action"
UP_QOS_URL="http://api.cloud.189.cn/family/qos/startQos.action"
count=0
echo "*******************************************"
while :
do
    count=$((count+1))
    echo "Sending heart_beat package <$count>"
    date=`date -u '+%a, %d %b %Y %T GMT'`
    data="SessionKey=$session_key&Operate=$method&RequestURI=$ACCESS_URL&Date=$date"
    key="$session_secret"
    signature=`hashHmac "sha1" "$data" "$key"`
    split="~"
    headers_string="SessionKey:$session_key"$split"Signature:$signature"$split"Date:$date"$split"$extra_header"
    headers=`formatHeaderString "$split" "$headers_string"`
    send_data="prodCode=$prodCode&version=$version&channelId=$channelId"
    result=`post "$headers" "$UP_QOS_URL" "$send_data"`
    echo "status_code:${result: -3}"
    echo -e "response:\n${result:0:$#-3}"
    [ "${result: -3}" = "400" ] &&  hint="succeeded" || hint="failed"
    echo "Sending heart_beat package <$count> $hint"
    echo "*******************************************"
    sleep $rate
done
