# How to Use

## Install Requirements

```bash
# Requirements on OpenWRT, Padavan, Merlin and other platform with entware or optware environment
opkg update && opkg install \
coreutils-nohup libreadline libcurl libopenssl bash curl wget openssl-util ca-certificates ca-bundle
```

## Download the Code, Edit Config File and Execute

```bash
chmod +x *.sh && ./speedup.sh
```

## Run by Crontab

```bash
# Passed testing on Padavan 3.4.3.9 and PandoraBox 17.01.
# Ensure 'speedup.sh' works fine and make 'certain_directory' replaced before adding.
# Manipulation with web control panel was recommended.
# For more syntax of crontab, search keyword `crontab format` on google.com.
crontab -l > conf && \
echo "*/10 * * * * /certain_directory/speedup_router.sh" >> conf && crontab conf && rm -f conf
```
