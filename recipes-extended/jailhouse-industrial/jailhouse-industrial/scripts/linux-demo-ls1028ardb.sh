#!/bin/bash

./init_jailhouse_env.sh

../tools/jailhouse disable;

../tools/jailhouse enable ../cells/ls1028a-rdb.cell;
../tools/jailhouse cell linux ../cells/ls1028a-rdb-linux-demo.cell -i ../inmates/rootfs/rootfs.cpio.gz ../inmates/kernel/Image -d ../inmates/dtb/inmate-ls1028a-rdb.dtb -c "console=ttyS0,115200 earlycon=uart8250,mmio,0x21c0600"

