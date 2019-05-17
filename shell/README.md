# How to Use

## Download the Code

Assuming you've installed git, then

```bash
git clone https://github.com/vcheckzen/FamilyCloudSpeederInShell.git

# CloudDisk
cd FamilyCloudSpeederInShell/CloudDisk

# FamilyCloud
cd FamilyCloudSpeederInShell/FamilyCloud
```

## Install Requirements

```bash
# Requirements on OpenWRT, Padavan and other RouterOS based on entware or optware environment
opkg update && \
opkg install coreutils-nohup libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle

# Test https and grep, a normal output is like "ip":"121.226.150.154"
curl -s https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
wget -qO- https://ipconfig.io/json | grep -Eo "\"ip\":\"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\""
```

### Testing Run

```bash
chmod +x speedup.sh utils.sh
./speedup.sh
```

### Run in Background

Please note that `certail_directory` should be replaced.

```bash
nohup /certail_directory/speedup.sh > /certail_directory/speedup.log 2>&1 &

# Log cleaning
crontab -l > tmp && \
echo "0 */6 * * * >/certail_directory/speedup.log" >> tmp && \
contab tmp && \rm -f tmp

```

### Auto Run on System Boot

You can add nohup command to `/etc/rc.local`, if the file exists in your system.

```bash
echo \
"nohup /certail_directory/speedup.sh > /certail_directory/speedup.log 2>&1 &" \
>> /etc/rc.local
```