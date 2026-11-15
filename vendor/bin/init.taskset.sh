#!/vendor/bin/sh

taskset -ap 3f `pidof -x kswapd0`
taskset -ap 3f `pidof -x kcompactd0`

