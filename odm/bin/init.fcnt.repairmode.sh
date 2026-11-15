#! /vendor/bin/sh
#----------------------------------------------------------------------------
# (C) 2022 FCNT LIMITED
#----------------------------------------------------------------------------
#check start
setprop persist.sys.usb.config adb
setprop sys.usb.config adb
echo "init.fcnt.repairmode.sh setprop sys.usb.config adb" > /dev/kmsg
#check
checkstatus=`getprop vendor.repair.mode`
conut=0
ret=1
while [ "$checkstatus" != "1" ]
do
    if [ $conut -ge 20 ]; then
        #go to offcharge
        setprop persist.sys.usb.config none
　　　   echo "init.fcnt.repairmode.sh go to offcharge setprop persist.sys.usb.config none" > /dev/kmsg
        echo "init.fcnt.repairmode.sh go to offcharge" > /dev/kmsg
        setprop sys.powerctl shutdown,offcharge
        ret=0
        break
    fi
    conut=`expr $conut + 1`
    sleep 1
    checkstatus=`getprop vendor.repair.mode`
done
if [ $ret -ne 0 ]; then
    echo "init.fcnt.repairmode.sh go to repairmode" > /dev/kmsg
    setprop sys.usb.config diag,adb,serial_cdev
    echo "init.fcnt.repairmode.sh setprop sys.usb.config diag,adb,serial_cdev" > /dev/kmsg
    setprop vendor.shipmode.disable 0
    sleep 10
    setprop persist.sys.usb.config none
    echo "init.fcnt.repairmode.sh setprop persist.sys.usb.config none" > /dev/kmsg
fi
