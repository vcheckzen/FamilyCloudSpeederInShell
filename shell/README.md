# How to Use

## Install Requirements

```bash
# Requirements on OpenWRT, Padavan and other RouterOS based on entware or optware environment
opkg update && \
opkg install coreutils-nohup libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle

# Test https and grep, a normal output is like "ip":"121.226.150.154"
curl -s https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
wget -qO- https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
```

## Download the Code, Edit Config File and Excute

```bash
chmod +x speedup.sh utils.sh
./speedup.sh
```
