REAL_TIME_EDGE_UBOOT_SRC ?= "git://github.com/nxp-real-time-edge-sw/real-time-edge-uboot.git;protocol=https"
REAL_TIME_EDGE_UBOOT_BRANCH ?= "uboot_v2024.04-3.0.0"
REAL_TIME_EDGE_UBOOT_SRCREV ?= "${AUTOREV}"

UBOOT_SRC = "${REAL_TIME_EDGE_UBOOT_SRC}"
UBOOT_BRANCH = "${REAL_TIME_EDGE_UBOOT_BRANCH}"
SRCREV = "${REAL_TIME_EDGE_UBOOT_SRCREV}"

# For BareMetal
REAL_TIME_EDGE_UBOOT_BAREMETAL_BRANCH ?= "baremetal-uboot_v2024.04-3.0.0"
REAL_TIME_EDGE_UBOOT_BAREMETAL_SRCREV ?= "${AUTOREV}"
UBOOT_BRANCH:baremetal = "${REAL_TIME_EDGE_UBOOT_BAREMETAL_BRANCH}"
SRCREV:baremetal = "${REAL_TIME_EDGE_UBOOT_BAREMETAL_SRCREV}"

SRC_URI = "${UBOOT_SRC};branch=${UBOOT_BRANCH}"

do_configure:prepend:real-time-edge() {
    mkdir -p ${WORKDIR}/source-date-epoch
    date '+%s' > ${WORKDIR}/source-date-epoch/__source_date_epoch.txt
}
