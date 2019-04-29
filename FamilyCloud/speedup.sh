#!/usr/bin/env bash

base_dir=`dirname $0`
source "$base_dir/utils.sh"
config="$base_dir/config.json"


e189AccessToken=`getSingleJsonValue "$config" "e189AccessToken"`
AppKey=`getSingleJsonValue "$config" "AppKey"`
AppSignature=`getSingleJsonValue "$config" "AppSignature"`
Timestamp=`getSingleJsonValue "$config" "Timestamp"`
method=`getSingleJsonValue "$config" "method"`
rate=`getSingleJsonValue "$config" "rate"`
UA=`getSingleJsonValue "$config" "User-Agent"`
prodCode=`getSingleJsonValue "$config" "prodCode"`
version=`getSingleJsonValue "$config" "version"`
channelId=`getSingleJsonValue "$config" "channelId"`
extra_header="User-Agent:$UA"


HOST="http://api.cloud.189.cn"
LOGIN_URL="/family/manage/loginFamily.action"
ACCESS_URL="/family/qos/startQos.action"
count=0
echo "*******************************************"
while :
do
    count=$((count+1))
    echo "Sending heart_beat package <$count>"
    split="~"
    headers_string="AppKey:$AppKey"${split}"AppSignature:$AppSignature"${split}"Timestamp:$Timestamp"${split}"$extra_header"
    headers=`formatHeaderString "$split" "$headers_string"`
    login_result="`get \"$HOST$LOGIN_URL?e189AccessToken=$e189AccessToken\" \"$headers\"`"
    session_key=`echo "$login_result" | grep -Eo "sessionKey>.*family" | sed 's/sessionKey>//'`
    session_secret=`echo "$login_result" | grep -Eo "sessionSecret>.*</sessionSecret" | sed 's/sessionSecret>//' | sed 's/<\/sessionSecret//'`
    date=`env LANG=C.UTF-8 date -u '+%a, %d %b %Y %T GMT'`
    data="SessionKey=$session_key&Operate=$method&RequestURI=$ACCESS_URL&Date=$date"
    key="$session_secret"
    signature=`hashHmac "sha1" "$data" "$key"`
    split="~"
    headers_string="SessionKey:$session_key"${split}"Signature:$signature"${split}"Date:$date"${split}"$extra_header"
    headers=`formatHeaderString "$split" "$headers_string"`
    send_data="prodCode=$prodCode&version=$version&channelId=$channelId"
    for i in 1 2 3
    do
        result=`post "$headers" "$HOST$ACCESS_URL" "$send_data"`
    done
    echo "heart_beat:<signature:$signature>"
    echo "date:<$date>"
    echo "status_code:${result: -3}"
    echo -e "response:\n`echo ${result} | sed "s^[0-9]\{3\}$^^"`"
    [[ "`echo ${result} | grep open`" != "" ]] &&  hint="succeeded" || hint="failed"
    echo "Sending heart_beat package <$count> $hint"
    echo "*******************************************"
    sleep ${rate}
done
