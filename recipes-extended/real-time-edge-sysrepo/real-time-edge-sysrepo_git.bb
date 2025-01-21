SUMMARY = "real-time-edge-sysrepo"
DESCRIPTION = "A tool to configure TSN functionalities in user space"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

REAL_TIME_EDGE_SYSREPO_SRC ?= "git://git@bitbucket.sw.nxp.com/dnind/real-time-edge-sysrepo.git;protocol=ssh"
REAL_TIME_EDGE_SYSREPO_BRANCH ?= "master"
REAL_TIME_EDGE_SYSREPO_SRCREV ?= "${AUTOREV}"

SRC_URI = "${REAL_TIME_EDGE_SYSREPO_SRC};branch=${REAL_TIME_EDGE_SYSREPO_BRANCH}"
SRCREV = "${REAL_TIME_EDGE_SYSREPO_SRCREV}"

SRC_URI += " \
    file://sysrepo-tsnd \
"

S = "${WORKDIR}/git"

DEPENDS = "libyang libnetconf2 sysrepo netopeer2-server cjson libnl tsntool"
RDEPENDS:${PN} += "bash curl libyang libnetconf2 sysrepo netopeer2-server cjson libnl tsntool"

FILES:${PN} += "/etc/sysrepo-tsn"

# can modify conf/distro/include/real-time-edge-base.inc for PACKAGECONFIG
PACKAGECONFIG ??= ""
PACKAGECONFIG[real-time-edge-sysrepo-tc] = "-DCONF_SYSREPO_TSN_TC=ON,-DCONF_SYSREPO_TSN_TC=OFF,"

inherit cmake pkgconfig

EXTRA_OECMAKE = " -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE:String=Release -DSYSREPOCTL_EXECUTABLE=/usr/bin/sysrepoctl -DSYSREPOCFG_EXECUTABLE=/usr/bin/sysrepocfg "

do_install:append () {
    install -d ${D}/etc/sysrepo-tsn/
    install -d ${D}/usr/share/yang/modules/netopeer2
    install -m 0775 ${S}/modules/*.yang ${D}/usr/share/yang/modules/netopeer2

    install -d ${D}/etc/init.d
    install -m 0755 ${WORKDIR}/sysrepo-tsnd ${D}/etc/init.d/

    install -d ${D}/etc/rc5.d
    install -d ${D}/etc/rc6.d
    ln -sfr ${D}/etc/init.d/sysrepo-tsnd ${D}/etc/rc5.d/S52sysrepo-tsnd
    ln -sfr ${D}/etc/init.d/sysrepo-tsnd ${D}/etc/rc6.d/K51sysrepo-tsnd
}
