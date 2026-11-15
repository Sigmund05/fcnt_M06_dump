#! /system/bin/sh

#----------------------------------------------------------------------------
# (C) 2022 FCNT LIMITED
#----------------------------------------------------------------------------

PERSIST_PATH="/mnt/makerlog/Logs"
RAMDUMP_LOG_TEXT="${PERSIST_PATH}/Ramdump.txt.gz.cip"

dd if=/dev/block/bootdevice/by-name/parseout bs=512 | gzip | /system/bin/aes_app -o ${RAMDUMP_LOG_TEXT}
chmod 666 ${RAMDUMP_LOG_TEXT}
chown root:log ${RAMDUMP_LOG_TEXT}
setprop debug.fta.ramdump 1
