#!/vendor/bin/sh
setprop persist.vendor.sys.checkfuse unfused
dd if=/dev/block/by-name/secdata of=/mnt/vendor/persist/sec.dat
brand_name="HUAQIN"
sec_info=`strings /mnt/vendor/persist/sec.dat`
if [[ $sec_info == *$brand_name* ]]; then
  setprop persist.vendor.sys.checkfuse fused
fi
rm /mnt/vendor/persist/sec.dat

if [ -f /mnt/vendor/persist/colorid.txt ]; then
    colorid=`xxd -p -l 1 /mnt/vendor/persist/colorid.txt`
    setprop persist.vendor.sys.colorid $colorid
fi

sku_path="/mnt/vendor/persist/operator.bin"
if [ -f $sku_path ]; then
    sku=`cat /mnt/vendor/persist/operator.bin`
    case "$sku" in
        "1")
        setprop vendor.km.brand FCNT
        setprop vendor.km.device F51E
        setprop vendor.km.name F51E
        setprop vendor.km.manufacturer FCNT
        setprop vendor.km.model F-51E
        ;;
        "5")
        setprop vendor.km.brand FCNT
        setprop vendor.km.device M06
        setprop vendor.km.name M06
        setprop vendor.km.manufacturer FCNT
        setprop vendor.km.model M06
        ;;
    esac
fi

