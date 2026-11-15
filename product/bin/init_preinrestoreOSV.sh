#!/system/bin/sh
#
# © FCNT LLC 2024 ALL Rights Reserved.
#==========================================================================================
# * HISTORY
# *
# *     Tag                         Date            Author           Description
# * =========================     ==============  ============     ========================
# * FJ_APP-01200-InitPreinrestore  2017/03/22      NSCo unno         LATTE-OSVN-SYSTEM-870
# * FJ_APP-01200-InitPreinrestore  2017/04/10      NSCo unno         GOLF-OSVN-SYSTEM-220
# * 19-1st-1484-5.1                2018/09/27      TS Cai Xiaonan    POSV対応
# * LIPTON-OSVP-SYSTEM-34          2018/11/16      TS Cai Xiaonan    Instagramのコメント欄の絵文字が表示されない対応
# * LIPTON-OSVP-SYSTEM-310         2018/12/7       TS Cai Xiaonan    【NX!メール】O-OSでNX!メールがダウンローダのまま、POSV後、NX!メールはダウンローダが表示しなくなる対応
# * 20-2nd_01484_ROSV対応          2020/11/12       TS_Meng Lingyu    ROSV対応
#==========================================================================================
# */

TAG=init_preinrestoreOSV.sh

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
#RESTORE_FLG_OSV=${FLGDIR}/RestoreCompleted_OOSV.flg
#RESTORE_LOG_OSV=${FLGDIR}/Restore_OOSV.log
#  FCNT:2018-9-27_19-1st-1484-5.1_MOD-S
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
#  FCNT:2024-11-26_01484-UOSV対応 MOD-S
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

log -t ${TAG} "preinrestoreOSV.sh hit"

if [ ! -e ${RESTORE_FLG} ]; then

#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 DEL-S
    log -t ${TAG} "preinrestore route"
#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 DEL-E

# TS:2015-07-03 LP-OSV プリイン復活 ADD-S

elif [ ! -e ${RESTORE_FLG_OSV} ]; then

    log -t ${TAG} "preinrestoreOSV osv start"
    echo "### preinrestoreOSV osv start" > ${RESTORE_LOG_OSV}

#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 DEL-S
#    OSVFUNC cd ${SYSDIR}
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 DEL-E

#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 DEL-S
#    for apk in `ls */*.apk`
#    do
#        if [ -e $apk.inf ]; then
#            pkg=`cat $apk.inf`
#            if [ -n "${pkg}" ]; then
#                if [ -e ${APPDIR}/$apk -a ${APPDIR}/$apk -nt ${SYSDIR}/$apk ]; then
#                    continue;
#                fi
#
#                OSVFUNC cp -rp ${SYSDIR}/${apk%/*.apk} ${APPDIR}
#                OSVFUNC chown -R system:system ${APPDIR}/${apk%/*.apk}
#                log -t ${TAG} "install $apk"
#            fi
#        fi
#    done
#    sync
#  FCNT:2017-3-22 [FJ_APP-01200-InitPreinrestore] N-OSV LATTE-OSVN-SYSTEM-870 DEL-E

    #### wait for PackageManager
    log -t ${TAG} "preinrestoreOSV osv wait for PackageManager start"
    sleep 10
    for i in 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0
    do
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 MOD-S
        path=`pm path com.android.systemui` 2>> ${RESTORE_LOG_OSV}
        out=`pm path com.android.systemui 2>&1`
        log -t ${TAG} "PID:"$$" pm_LOG:"${out}
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 MOD-E
        if [ -n "${path}" ]; then
            log -t ${TAG}  "break"
            break;
        fi
        sleep 3
    done
    log -t ${TAG} "preinrestoreOSV osv wait for PackageManager end"

# FCNT:2020-2-11_BVLGARI-OSVQ-PARTS-350_MOD-S
    sleep 60
# FCNT:2018-12-7_BVLGARI-OSVQ-PARTS-350_MOD-E
    #### Installation Package
    log -t ${TAG} "preinrestoreOSV osv upd check start"
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 MOD-S
#    OSVFUNC cd ${SYSDIR}
#    for apk in `ls */*.apk`
    for apk in `ls ${SYSDIR}/*/*.apk`
    do
        log -t ${TAG} "upd check $apk"
        if [ -e $apk.upd ]; then
            pkg=`cat $apk.upd`
            log -t ${TAG} "pkg= $pkg"
            if [ -n "${pkg}" ]; then
                path=`pm path $pkg`
                log -t ${TAG} "path= $path"
                if [ -n "${path}" ]; then
#                    OSVFUNC pm install -r ${SYSDIR}/$apk
                    out=`pm install -r $apk 2>&1`
                    log -t ${TAG} "pm_install_LOG:"${out}
                    log -t ${TAG} "update $apk"

# FCNT:2020-2-11_BVLGARI-OSVQ-PARTS-350_MOD-S
                    if [ ${out:0:7} != "Success" ]; then
                        for i in 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0
                        do
                            log -t ${TAG} "preinrestoreOSV osv wait for SystemServicesReady"
                            sleep 10
                            out=`pm install -r $apk 2>&1`
                            log -t ${TAG} "pm_install_LOG:"${out}
                            log -t ${TAG} "update $apk"

                            if [ ${out} == "Success" ]; then
                                 log -t ${TAG}  "SystemServicesReady is OK break"
                                  break;
                            fi
                        done
                    fi
# FCNT:2020-2-11_BVLGARI-OSVQ-PARTS-350_MOD-E
                fi
            fi
        fi
#  FCNT:2018-01-19 [FJ_APP-01200-InitPreinrestore] O-OSV プリイン復活への要望 ADD-S
        if [ -e $apk.upd2 ]; then
            pkg2=`cat $apk.upd2`
            log -t ${TAG} "pkg2= $pkg2"
            if [ -n "${pkg2}" ]; then
                path2=`pm path $pkg2`
                log -t ${TAG} "path2= $path2"
# FCNT:2018-12-7_LIPTON-OSVP-SYSTEM-310_MOD-S
#  FCNT:2018-02-07 [FJ_APP-01200-InitPreinrestore] O-OSV FUTSAL-OSVO-SYSTEM-334 MOD-S
#                if [ ${path2:0,18}=="package:/data/app/"]; then
#                if [ ${path2:0:18}=="package:/data/app/" ]; then
                if [ ${path2:0:18} == "package:/data/app/" ]; then
#  FCNT:2018-02-07 [FJ_APP-01200-InitPreinrestore] O-OSV FUTSAL-OSVO-SYSTEM-334 MOD-E
# FCNT:2018-12-7_LIPTON-OSVP-SYSTEM-310_MOD-E
                    out=`pm install -r $apk 2>&1`
                    log -t ${TAG} "pm_install_LOG:"${out}
                    log -t ${TAG} "update $apk"
# FCNT:2020-2-11_BVLGARI-OSVQ-PARTS-350_MOD-S
                    if [ ${out:0:7} != "Success" ]; then
                        for i in 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0
                        do
                            log -t ${TAG} "preinrestoreOSV osv wait for SystemServicesReady"
                            sleep 10
                            out=`pm install -r $apk 2>&1`
                            log -t ${TAG} "pm_install_LOG:"${out}
                            log -t ${TAG} "update $apk"

                            if [ ${out} == "Success" ]; then
                                 log -t ${TAG}  "SystemServicesReady is OK break"
                                  break;
                            fi
                        done
                    fi
# FCNT:2020-2-11_BVLGARI-OSVQ-PARTS-350_MOD-E
                fi
            fi
        fi
#  FCNT:2018-01-19 [FJ_APP-01200-InitPreinrestore] O-OSV プリイン復活への要望 ADD-E
    done
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 MOD-E
    sync
    sleep 5
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 MOD-S
#    OSVFUNC touch ${RESTORE_FLG_OSV}
    out=`touch ${RESTORE_FLG_OSV} 2>&1`
    log -t ${TAG} "PID:"$$" touch_LOG:"${out}
#  FCNT:2017-4-10 [FJ_APP-01200-InitPreinrestore] N-OSV GOLF-OSVN-SYSTEM-220 MOD-E
    sync

    log -t ${TAG} `cat ${RESTORE_LOG_OSV}`
    log -t ${TAG} "preinrestoreOSV osv end"
    echo "### preinrestoreOSV osv end" >> ${RESTORE_LOG_OSV}
# TS:2015-07-03 LP-OSV プリイン復活 ADD-E
fi
