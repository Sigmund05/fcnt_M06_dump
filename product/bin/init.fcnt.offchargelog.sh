#!/system/bin/sh
#---------------------------------------
# (C) 2023 FCNT LIMITED
#---------------------------------------

function folder_size_check() {
    if [ `du -l ${logdir}  | cut -f 1` -ge ${foldermaxsize} ] ; then
        while [ `du -l ${logdir}  | cut -f 1` -ge ${foldermaxsize} ]
        do
            firstlog=`ls -1 ${logdir} | grep "offcharge_" | cut -f 3 -d "_" | sort -n | head -n 1`
            deletefile=`ls -1 ${logdir} | grep "_${firstlog}" | head -n 1`
            log -p i "offchargelog delete ${logdir}/${deletefile}"
            rm ${logdir}/${deletefile}
        done
    fi
}

function write_log() {
    if [ ! -e ${logdir}/offcharge_${bootcnt}_${logcnt}.log ]; then
        touch ${logdir}/offcharge_${bootcnt}_${logcnt}.log
        chmod 664 ${logdir}/offcharge_${bootcnt}_${logcnt}.log
    else
        logfilesize=`wc -c ${logdir}/offcharge_${bootcnt}_${logcnt}.log | cut -d ' ' -f1 -`
        if [ ${logfilesize} -gt ${logmaxsize} ]; then
            increment_cnt
            touch ${logdir}/offcharge_${bootcnt}_${logcnt}.log
            chmod 664 ${logdir}/offcharge_${bootcnt}_${logcnt}.log
        fi
    fi

    log -p i "offchargelog write ${logdir}/offcharge_${bootcnt}_${logcnt}.log"
    dmesg -c >> ${logdir}/offcharge_${bootcnt}_${logcnt}.log
}

function increment_cnt() {
    logcnttmp=`expr $logcnt + 1`
    if [ ${logcnttmp} -gt  ${logcntmax} ]; then
        rm ${logdir}/offcharge_*
        logcnttmp=0
        log -p i "offchargelog delete all"
    fi
    logcnt=`printf %08d ${logcnttmp}`
    log -p i "offchargelog logcnt  ${logcnt}"
    echo ${logcnt} > ${currentfile}
}

logmaxsize=1000000
foldermaxsize=49000
logcntmax=99999999
rootdir="/mnt/makerlog/Logs"
logdir=${rootdir}"/charger"
currentfile=${logdir}"/current"

closeflg=`getprop vendor.offchargelog.close`

log -p i "offchargelog start"

bootcnt=`getprop ro.boot.bootcount`
if [ -z "${bootcnt}" ]; then
    bootcnt="0000"
else
    bootcnt=`printf %04d $bootcnt`
fi

if [ "${closeflg}" != "true" ]; then
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
            log -p i "offchargelog mkdir failed"
            exit 1
        fi
        chmod 775 ${logdir}
    fi

    if [ -e ${currentfile} ]; then
        logcnt=`cat ${currentfile}`
        increment_cnt
    else
        logcnt="00000000"
        echo ${logcnt} > ${currentfile}
        chmod 664 ${currentfile}
    fi

    while [ -e ${logdir}/offcharge_${bootcnt}_${logcnt}.log ]
    do
       increment_cnt
    done

    while :
    do
        folder_size_check
        write_log

        sleep 20
    done
else
    if [ -e ${currentfile} ]; then
        logcnt=`cat ${currentfile}`
        folder_size_check
        write_log
    fi
    setprop vendor.offchargelog.close "false"
fi
