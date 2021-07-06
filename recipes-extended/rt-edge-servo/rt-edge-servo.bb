# Copyright 2021 NXP

PV = "1.0"
DESCRIPTION = "CoE test tool"
LICENSE = "GPL-2.0 & MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ef58f855337069acd375717db0dbbb6d"
RT_EDGE_SERVO_BRANCH = "master"
SRC_URI = "git://github.com/rt-edge-sw/rt-edge-servo.git;protocol=https;branch=${RT_EDGE_SERVO_BRANCH}"
SRCREV = "030329089da57d68fb60d0c7f115b5f45e7b17af"

S = "${WORKDIR}/git"

DEPENDS = "libxml2 igh-ethercat"
inherit pkgconfig

do_configure () {
	:
}

EXTRA_OEMAKE = " \
    PKG_CONFIG="${STAGING_BINDIR_NATIVE}/pkg-config" \
    DESTDIR="${D}"\
    HOME_DIR="${ROOT_HOME}" \
"

do_compile () {
    oe_runmake -C ${S} ${EXTRA_OEMAKE}
}

do_install() {
   oe_runmake install -C ${S} ${EXTRA_OEMAKE}
   oe_runmake install-libs -C ${S} ${EXTRA_OEMAKE}
}

FILES_${PN} += "${bindir_native}/* ${sbindir_native}/* ${libdir_native}/* ${ROOT_HOME}/*"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
