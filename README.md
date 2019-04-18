# FamilyCloudSpeederInShell

## Introduction

A Shell Implementation of FamilyCloudSpeeder, ESurfing, which can be used in almost all linux platform.

## How to Use

### Download the Code

Assuming you've installed git, then

```bash
git clone https://github.com/vcheckzen/FamilyCloudSpeederInShell.git
cd FamilyCloudSpeederInShell
```

### Get Your Specific Parameters

Fill in the `config.json` file, following [this](https://github.com/aiyijing/familycloudaccelerate/wiki/%E5%AE%B6%E5%BA%AD%E4%BA%91%E6%89%8B%E6%9C%BA%E7%AB%AF%E6%8A%93%E5%8C%85%E6%96%B9%E6%B3%95) and [this guide](https://github.com/aiyijing/familycloudaccelerate/issues/5).

### Run `speedup.sh` to Test

```bash
chmod +x speedup.sh
./speedup.sh
```

### Run in Background

Please note that `certail_directory` should be replaced.

```bash
nohup /certail_directory/FamilyCloudSpeederInShell/speedup.sh > /certail_directory/FamilyCloudSpeederInShell/speedup.log 2>&1 &
```

### Auto Run on System Boot

You can add nohup command to `/etc/rc.local`, if the file exists in your system.

```bash
echo \
"nohup /certail_directory/FamilyCloudSpeederInShell/speedup.sh > /certail_directory/FamilyCloudSpeederInShell/speedup.log 2>&1 &" \
>> /etc/rc.local
```

# Appreciation

- [familycloudaccelerate](https://github.com/aiyijing/familycloudaccelerate)
