#!/vendor/bin/sh

#pcbid=`cat /sys/bus/platform/drivers/HardwareInfo/HardwareInfo/modem_id`
fsg_flag_path="/mnt/vendor/persist/flag/fsg_flag"
current_time=`date +%Y%m%e%H%M%S`

if [ -f /mnt/vendor/persist/colorid.txt ]; then
    colorid=`cat /mnt/vendor/persist/colorid.txt`
    setprop persist.vendor.sys.colorid $colorid
fi

#echo "pcbid is : $pcbid"
if [ ! -f $fsg_flag_path ];then

    if [ -f /vendor/etc/fsg/fs_image.tar.gz.mbn.img ]; then
        dd if=/vendor/etc/fsg/fs_image.tar.gz.mbn.img of=/dev/block/bootdevice/by-name/fsg
        echo "write fsg"
    fi

touch $fsg_flag_path
echo $pcbid_$current_time > $fsg_flag_path

fi


