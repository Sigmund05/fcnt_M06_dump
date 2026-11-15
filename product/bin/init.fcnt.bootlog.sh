#!/system/bin/sh
#----------------------------------------------------------------------------
# (C) 2023 FCNT LIMITED
#----------------------------------------------------------------------------
rootdir="/mnt/makerlog/Logs"
logdir=${rootdir}"/bootlog"
indir="/mnt/logfs"
encbin="/system/bin/aes_app"

while :
do
    if [ -e ${rootdir} ]; then
        break
    fi
    sleep 1
done

if [ ! -e ${logdir} ]; then
    mkdir ${logdir}
    if [ ! ${?} == 0 ] ; then
        log -p i "bootlog mkdir failed"
        setprop vendor.bootlog.saved 1
        exit 1
    fi
    chmod 775 ${logdir}
fi

for i in `seq 0 4`
do
    if [ -e ${indir}/UefiLog${i}.txt ]; then
        if [ -e ${encbin} ]; then
            dd if=${indir}/UefiLog${i}.txt bs=16K | gzip | ${encbin} -o ${logdir}/UefiLog${i}.gz.cip
            chmod 664 ${logdir}/UefiLog${i}.gz.cip
        else
            dd if=${indir}/UefiLog${i}.txt bs=16K | gzip -c > ${logdir}/UefiLog${i}.txt.gz
            chmod 664 ${logdir}/UefiLog${i}.txt.gz
        fi
    fi
done

setprop vendor.bootlog.saved 1
