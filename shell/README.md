# How to Use

## Install Requirements

```bash
# Requirements on OpenWRT, Padavan and other RouterOS based on entware or optware environment
opkg update && opkg install \
coreutils-nohup libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle

# Test https and grep, a normal output is like "ip":"121.226.150.154"
curl -s https://ipconfig.io/json | grep -Eo '"ip":"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"'
wget -qO- https://ipconfig.io/json | grep -Eo '"ip":"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"'
```

## Download the Code, Edit Config File Then, Excute

```bash
chmod +x speedup.sh utils.sh && ./speedup.sh
```

## Run by Crontab

```bash
# Successful on Padavan 3.4.3.9 and PandoraBox 17.01, please ensure speedup.sh can work correctly.
# !!Recommended you edit Crontab in your router's WEB control panel.
# Otherwise run this shell, Please note that `certain_directory` should be replaced. 
# For more details, please search for the crontab syntax.

crontab -l > conf && echo "*/10 * * * * /certain_directory/speedup_router.sh" >> conf && crontab conf && rm -f conf
```
