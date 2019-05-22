#!/usr/bin/env bash

padavan(){
    BASE_DIR='/etc/storage/'
    BOOT_FILE=${BASE_DIR}script/Sh99_cloudisk.sh
    chmod +x ${BASE_DIR}CloudDisk/*.sh
    echo -e "" > ${BOOT_FILE}
}