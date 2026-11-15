#!/vendor/bin/sh

apply_sar() {
    if [ "$1" = 0 ];
    then
        cmd="vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD"
    else
        cmd="vendor_cmd_tool -f /vendor/bin/sar-vendor-cmd.xml -i wlan0 --START_CMD --SAR_SET --ENABLE 7 --NUM_SPECS 2 --SAR_SPEC --NESTED_AUTO --CHAIN 0 --POW_IDX $1 --END_ATTR --NESTED_AUTO --CHAIN 1 --POW_IDX $1 --END_ATTR --END_ATTR --END_CMD"
    fi

    echo "$cmd"

    $cmd
}
backoff_power=$(getprop "persist.vendor.wifi.sar" "0")
apply_sar $backoff_power