# FamilyCloudSpeederInShell

## Introduction

A shell implementation of FamilyCloudSpeeder, ESurfing, runs properly on almost all linux platform.

## How to Use

### Download the Code

Assuming you've installed git, then

```bash
git clone -b beta https://github.com/vcheckzen/FamilyCloudSpeederInShell.git

# CloudDisk
cd FamilyCloudSpeederInShell/CloudDisk

# FamilyCloud
cd FamilyCloudSpeederInShell/FamilyCloud
```

### Get Your Specific Parameters

Fill in the `config.json` file, following [this](https://github.com/aiyijing/familycloudaccelerate/wiki/%E5%AE%B6%E5%BA%AD%E4%BA%91%E6%89%8B%E6%9C%BA%E7%AB%AF%E6%8A%93%E5%8C%85%E6%96%B9%E6%B3%95) and [this guide](https://github.com/aiyijing/familycloudaccelerate/issues/5). Note that you should open CloudDisk APP rather than FamilyCloud. Then, get parameters from the request below.

```bash
Host: api.cloud.189.cn
Path: login4MergedClient.action, loginByOpen189AccessToken.action
```

### Install Requirements and Test Environment

```bash
# Requirements on OpenWRT, Padavan and other RouterOS based on entware or optware environment
opkg update && \
opkg install coreutils-nohup libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle

# Test https and grep, a normal output is like "ip":"121.226.150.154"
curl -s https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
wget -qO- https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
```

### Run `speedup.sh` to Test

```bash
chmod +x speedup.sh utils.sh
./speedup.sh
```

### Run in Background

Please note that `certail_directory` should be replaced.

```bash
nohup /certail_directory/speedup.sh > /certail_directory/speedup.log 2>&1 &
```

### Auto Run on System Boot

You can add nohup command to `/etc/rc.local`, if the file exists in your system.

```bash
echo \
"nohup /certail_directory/speedup.sh > /certail_directory/speedup.log 2>&1 &" \
>> /etc/rc.local
```

# Appreciation

- [familycloudaccelerate](https://github.com/aiyijing/familycloudaccelerate)
