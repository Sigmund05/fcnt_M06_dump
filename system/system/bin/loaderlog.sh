#! /system/bin/sh

#----------------------------------------------------------------------------
# (C) 2021, 2022 FCNT LIMITED
#----------------------------------------------------------------------------

PERSIST_PATH="/mnt/makerlog/Logs"
LOADER_LOG_CIP="${PERSIST_PATH}/loaderlog.gz.cip"

# FUJITSU:2015-05-13 GEN-132-LOG-DETAL-001_SPEC-GEN MOD-S
#dd if=/dev/block/platform/f9824900.sdhci/by-name/loaderlog bs=512 | gzip | aes_app -o ${LOADER_LOG_CIP}
# FCNT:2021-09-16 ATAMIDCM-SYSTEM-1294 ADD-S
sleep 1
# FCNT:2021-09-16 ATAMIDCM-SYSTEM-1294 ADD-E
dd if=/dev/block/bootdevice/by-name/loaderlog bs=512 | gzip | /system/bin/aes_app -o ${LOADER_LOG_CIP}
# FUJITSU:2015-05-13 GEN-132-LOG-DETAL-001_SPEC-GEN MOD-E
chmod 666 ${LOADER_LOG_CIP}

# FCNT:2017-08-30 FUTSAL-SYSTEM-927 ADD-S
SUMMARY_LOG_TXT="${PERSIST_PATH}/summary.txt"
dd if=/dev/block/bootdevice/by-name/fjlog bs=4 skip=770051 count=1 of=${SUMMARY_LOG_TXT}
chmod 666 ${SUMMARY_LOG_TXT}
# FCNT:2017-08-30 FUTSAL-SYSTEM-927 ADD-E
