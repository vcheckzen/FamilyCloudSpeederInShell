# How to Use

## Install Requirements

```bash
# Requirements on OpenWRT, Padavan, Merlin and other platform with entware or optware environment
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
# Passed Testing on Padavan 3.4.3.9 and PandoraBox 17.01.
# Ensure speedup.sh works fine and make 'certain_directory' replaced before Adding.
# Manipulation with router's web control panel was recommended.
# For more details, search for crontab syntax on your own.
crontab -l > conf && \
echo "*/10 * * * * /certain_directory/speedup_router.sh" >> conf && crontab conf && rm -f conf
```
