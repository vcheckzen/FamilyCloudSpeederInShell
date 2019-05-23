#!/usr/bin/env bash

# copyright logi all rights reserved.

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
    if [[ "`cat conf | grep -Eo speedup_router`" == "" ]]; then
        echo "*/10 * * * * /etc/storage/CloudDisk/speedup_router.sh" >> conf
        crontab conf
    fi
    rm -f conf
    mtd_storage.sh save
}

merlin_bootup() {
    BASE_DIR='/jffs/scripts/'
    BOOT_FILE=${BASE_DIR}cloudisk_bootup.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/merlin/cloudisk_bootup.sh
    if [[ "`cat ${BASE_DIR}wan-start | grep -Eo ${BOOT_FILE}`" == "" ]]; then
        echo "source ${BOOT_FILE}" >> ${BASE_DIR}wan-start
    fi
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
}

merlin_cron() {
    BASE_DIR='/jffs/scripts/'
    BOOT_FILE=${BASE_DIR}/cloudisk_requirements.sh
    curl -o ${BOOT_FILE} https://raw.githubusercontent.com/vcheckzen/FamilyCloudSpeederInShell/assistantce/install/merlin/cloudisk_requirements.sh
    if [[ "`cat ${BASE_DIR}wan-start | grep -Eo ${BOOT_FILE}`" == "" ]]; then
         echo "source ${BOOT_FILE}" >> ${BASE_DIR}wan-start
    fi
    chmod +x ${BASE_DIR}CloudDisk/*.sh ${BOOT_FILE}
    crontab -l > conf
    if [[ "`cat conf | grep -Eo speedup_router`" == "" ]]; then
        echo "*/10 * * * * ${BASE_DIR}CloudDisk/speedup_router.sh" >> conf
        crontab conf
    fi
    rm -f conf
}

openwrt_bootup() {
    chmod +x /root/CloudDisk/*.sh
    if [[ "`cat /etc/rc.local | grep -Eo speedup`" == "" ]]; then
        sed '1i nohup /root/CloudDisk/speedup.sh >/dev/null 2>&1 &' -i /etc/rc.local
    fi
}

openwrt_cron() {
    chmod +x /root/CloudDisk/*.sh
    /etc/init.d/cron enable
    /etc/init.d/cron start
    crontab -l > conf
    if [[ "`cat conf | grep -Eo speedup_router`" == "" ]]; then
        echo "*/10 * * * * /root/CloudDisk/speedup_router.sh" >> conf
        crontab conf
    fi
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