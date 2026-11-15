#!/system/bin/sh
#
# © FCNT LLC 2024 ALL Rights Reserved.
#==================================================================================
# * HISTORY
# *
# *     Tag                         Date            Author           Description
# * =========================     ==============  ============     ================================
# * プリイン復活                   2015/07/03      TS Dong Jin       Add for support OSV upgrade
# * FJ_APP-01200-InitPreinrestore  2017/03/22      NSCo unno         LATTE-OSVN-SYSTEM-870
# * 19-1st-1484-5.1                2018/09/27      TS Cai Xiaonan    POSV対応
# * LIPTON-OSVP-SYSTEM-34          2018/11/16      TS Cai Xiaonan    Instagramのコメント欄の絵文字が表示されない対応
# * 20-2nd_01484_ROSV対応          2020/11/12       TS_Meng Lingyu    ROSV対応
#==================================================================================================
# */

TAG=init_preinrestore.sh
SYSDIR=/product/etc/preinstalled_app
# FCNT:2018-11-16_LIPTON-OSVP-SYSTEM-34_MOD-S
#  FCNT:2017-12-14 [FJ_APP-01200-InitPreinrestore] LIPTON Treble対応 MOD-S
#FLGDIR=/data/master
#FLGDIR=/data/vendor/master
#  FCNT:2017-12-14 [FJ_APP-01200-InitPreinrestore] LIPTON Treble対応 MOD-E
FLGDIR=/data/master
# FCNT:2018-11-16_LIPTON-OSVP-SYSTEM-34_MOD-E
APPDIR=/data/app

RESTORE_FLG=${FLGDIR}/RestoreCompleted.flg
# TS:2015-07-03 LP-OSV プリイン復活 ADD-S
#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 MOD-S
#  FCNT:2017-11-23 [FJ_APP-01200-InitPreinrestore] O-OSV OOSV対応 MOD-S
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_NOSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_NOSV.log
#  FCNT:2018-9-27_19-1st-1484-5.1_MOD-S
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_OOSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_OOSV.log
#  FCNT:2020-11-12_01484-ROSV対応 MOD-S
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_QOSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_QOSV.log
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_ROSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_ROSV.log
#  FCNT:2022-09-29_01484-TOSV対応 MOD-S
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_SOSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_SOSV.log
#  FCNT:2024-01-18_01484-UOSV対応 MOD-S
#  RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_TOSV.flg
#  RESTORE_LOG_OSV=${FLGDIR}/Restore_TOSV.log
#  FCNT:2024-11-26_01484-VOSV対応 MOD-S
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_UOSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_UOSV.log
# RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_VOSV.flg
# RESTORE_LOG_OSV=${FLGDIR}/Restore_VOSV.log
#  FCNT:2026-01-21_01484-WOSV対応 MOD-S
RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_WOSV.flg
RESTORE_LOG_OSV=${FLGDIR}/Restore_WOSV.log
#  FCNT:2024-01-21_01484-WOSV対応 MOD-E
#  FCNT:2024-11-26_01484-VOSV対応 MOD-E
#  FCNT:2024-01-18_01484-UOSV対応 MOD-E
#  FCNT:2022-09-29_01484-TOSV対応 MOD-E
#  FCNT:2020-11-12_01484-ROSV対応 MOD-E
#  FCNT:2018-9-27_19-1st-1484-5.1_MOD-E
#  FCNT:2017-11-23 [FJ_APP-01200-InitPreinrestore] O-OSV OOSV対応 MOD-E
#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 MOD-E
# TS:2015-07-03 LP-OSV プリイン復活 ADD-E

FUNC(){
    $* || log -t ${TAG} "FAILED($?): $*"
}

# TS:2015-07-03 LP-OSV プリイン復活 ADD-S
OSVFUNC(){
    echo "$*" >> ${RESTORE_LOG_OSV}
    $* >> ${RESTORE_LOG_OSV} 2>&1 || log -t ${TAG} "FAILED($?): $*"
}
# TS:2015-07-03 LP-OSV プリイン復活 ADD-E

log -t ${TAG} "preinrestore.sh hit"

if [ ! -e ${RESTORE_FLG} ]; then

    log -t ${TAG} "preinrestore start"

#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 DEL-S
#    umask 022
#    if [ ! -d ${FLGDIR} ]; then
#        FUNC mkdir ${FLGDIR}
#    fi
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 DEL-E
    FUNC cd ${SYSDIR}
# TS:2015-07-03 LP-OSV プリイン復活 MOD-S
    for apk in `ls */*.apk`
    do
#  FCNT:2018-01-19 [FJ_APP-01200-InitPreinrestore] O-OSV プリイン復活への要望 ADD-S
        if [ -e $apk.upd2 ]; then
            continue
        fi
#  FCNT:2018-01-19 [FJ_APP-01200-InitPreinrestore] O-OSV プリイン復活への要望 ADD-E
        FUNC cp -rp ${SYSDIR}/${apk%/*.apk} ${APPDIR}
        FUNC chown -R system:system ${APPDIR}/${apk%/*.apk}
# TS:2015-07-03 LP-OSV プリイン復活 MOD-E
        log -t ${TAG} "preinrestore $apk"
    done
    sync
    sleep 5
    FUNC touch ${RESTORE_FLG}
# TS:2015-07-03 LP-OSV プリイン復活 ADD-S
    FUNC touch ${RESTORE_FLG_OSV}
# TS:2015-07-03 LP-OSV プリイン復活 ADD-E
    sync

# TS:2015-07-03 LP-OSV プリイン復活 ADD-S
    log -t ${TAG} "preinrestore end"

elif [ ! -e ${RESTORE_FLG_OSV} ]; then
#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 DEL-S
    log -t ${TAG} "preinrestore osv route"
#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 DEL-E

# TS:2015-07-03 LP-OSV プリイン復活 ADD-E
fi
