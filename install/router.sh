#!/usr/bin/env bash

padavan(){
    BASE_DIR='/etc/storage/'
    BOOT_FILE=${BASE_DIR}script/Sh99_cloudisk.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/padavan/Sh99_cloudisk.sh
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
    mtd_storage.sh save
}

merlin() {
    BASE_DIR='/jffs/scripts/'
    BOOT_FILE=${BASE_DIR}script/cloudisk_bootup.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/merlin/cloudisk_bootup.sh
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
}

openwrt() {
    chmod +x /root/CloudDisk/*.sh
    sed '1i nohup /root/CloudDisk/speedup.sh > /dev/null 2>&1 &' -i /etc/rc.local
}