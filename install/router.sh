#!/usr/bin/env bash

padavan_bootup(){
    BASE_DIR='/etc/storage/'
    BOOT_FILE=${BASE_DIR}script/Sh99_cloudisk.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/padavan/Sh99_cloudisk.sh
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
    mtd_storage.sh save
}

padavan_cron(){
    BASE_DIR='/etc/storage/'
    BOOT_FILE=${BASE_DIR}script/Sh99_install_requirements_for_clouddisk.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/padavan/Sh99_install_requirements_for_clouddisk.sh
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
    crontab -l > conf
    echo "*/10 * * * * /etc/storage/CloudDisk/speedup_router.sh" >> conf
    crontab conf
    rm -f conf
    mtd_storage.sh save
}

merlin_bootup() {
    BASE_DIR='/jffs/scripts/'
    BOOT_FILE=${BASE_DIR}script/cloudisk_bootup.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/merlin/cloudisk_bootup.sh
    echo "source ${BOOT_FILE}" >> ${BASE_DIR}wan-start
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
}

merlin_cron() {
    BASE_DIR='/jffs/scripts/'
    BOOT_FILE=${BASE_DIR}script/cloudisk_requirements.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/merlin/cloudisk_requirements.sh
    echo "source ${BOOT_FILE}" >> ${BASE_DIR}wan-start
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
}

openwrt_bootup() {
    chmod +x /root/CloudDisk/*.sh
    sed '1i nohup /root/CloudDisk/speedup.sh > /dev/null 2>&1 &' -i /etc/rc.local
}

openwrt_cron() {
    /etc/init.d/cron enable
    /etc/init.d/cron start
    crontab -l > conf
    echo "*/10 * * * * /root/CloudDisk/speedup_router.sh" >> conf
    crontab conf
    rm -f conf
}

case $1 in
    padavan_bootup)  padavan_bootup
    ;;
    padavan_cron)  padavan_cron
    ;;
    merlin_bootup)  merlin_bootup
    ;;
    merlin_cron)  merlin_cron
    ;;
    openwrt_bootup)  openwrt_bootup
    ;;
    openwrt_cron)  openwrt_cron
    ;;
    *)  echo '仅支持 padavan, merlin 和类 openwrt 固件'
    ;;
esac