FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCBRANCH = "lf-5.10.y_v0.12"
RT_EDGE_JAILHOUSE_SRC ?= "git://source.codeaurora.org/external/imx/imx-jailhouse.git;protocol=ssh"

SRC_URI = "${RT_EDGE_JAILHOUSE_SRC};branch=${SRCBRANCH} \
           file://scripts/init_jailhouse_env.sh \
           file://scripts/uart-demo-ls1043ardb.sh \
           file://scripts/gic-demo-ls1043ardb.sh \
           file://scripts/ivshmem-demo-ls1043ardb.sh \
           file://scripts/linux-demo-ls1043ardb.sh \
           file://scripts/linux-demo-ls1043ardb-dpaa.sh \
           file://scripts/uart-demo-ls1046ardb.sh \
           file://scripts/gic-demo-ls1046ardb.sh \
           file://scripts/ivshmem-demo-ls1046ardb.sh \
           file://scripts/linux-demo-ls1046ardb.sh \
           file://scripts/linux-demo-ls1046ardb-dpaa.sh \
           file://scripts/uart-demo-ls1028ardb.sh \
           file://scripts/gic-demo-ls1028ardb.sh \
           file://scripts/ivshmem-demo-ls1028ardb.sh \
           file://scripts/linux-demo-ls1028ardb.sh \
           file://scripts/uart-demo-imx8mp.sh \
           file://scripts/gic-demo-imx8mp.sh \
           file://scripts/ivshmem-demo-imx8mp.sh \
           file://scripts/linux-demo-imx8mp.sh \
           file://rootfs.cpio.gz \
           file://0001-tools-scripts-update-shebang-to-python3.patch \
           file://0002-configs-ls1046a-rdb-add-cell-configure-files.patch \
           file://0003-configs-ls1046a-rdb-Add-linux-inmate-dts-demo.patch \
           file://0004-configs-ls1043a-rdb-add-cell-configure-files.patch \
           file://0005-configs-ls1043a-rdb-Add-linux-inmate-dts-demo.patch \
           file://0006-configs-ls1043a-rdb-add-DPAA-support-in-cell-configu.patch \
           file://0007-configs-ls1043a-rdb-add-DPAA-fman-ucode-dtsi-file.patch \
           file://0008-configs-ls1043a-rdb-add-DPAA-support-in-linux-inmate.patch \
           file://0009-configs-ls1043a-rdb-add-fman-ucode-memory-for-root-c.patch \
           file://0010-configs-ls1043ardb-Add-gpio1-in-non-root-config-and-.patch \
           file://0011-config-ls1046ardb-modify-memory-range-align-with-ls1.patch \
           file://0012-configs-ls1046ardb-add-memory-for-root-cell-fix-band.patch \
           file://0013-configs-ls1046ardb-Add-fman-ucode-dtsi-file.patch \
           file://0014-configs-ls1046ardb-Add-dpaa-support-for-non-root-lin.patch \
           file://0015-configs-ls1046ardb-Add-gpio1-in-config-and-dts-file.patch \
           file://0016-configs-arm64-Add-support-for-NXP-LS1028ARDB-platfor.patch \
           file://0017-configs-arm64-Add-Linux-inmate-DTS-demo-for-NXP-LS10.patch \
           file://0018-update-ls1028a-rdb-config-and-dts-for-openil.patch \
           file://0019-configs-arm64-Add-inmate-device-tree-for-the-i.MX8MP.patch \
"

SRCREV = "6a4d89fc27b33bc1d2657ffa7fd7380f061b21a4"

DEPENDS += " \
    python3-zipp \
"

inherit module python3native bash-completion deploy setuptools3

SCRIPT_DIR ?= "${JH_DATADIR}/scripts"

do_install_append() {
    install -d ${D}${SCRIPT_DIR}
    install ${S}/../scripts/*.sh ${D}${SCRIPT_DIR}/

    install -d ${D}${INMATES_DIR}/rootfs
    install ${S}/../rootfs.cpio ${D}${INMATES_DIR}/rootfs/

    install -d ${D}${INMATES_DIR}/dtb
    install ${B}/configs/${JH_ARCH}/dts/inmate-ls1043a*.dtb ${D}${INMATES_DIR}/dtb
    install ${B}/configs/${JH_ARCH}/dts/inmate-ls1046a*.dtb ${D}${INMATES_DIR}/dtb
    install ${B}/configs/${JH_ARCH}/dts/inmate-ls1028a*.dtb ${D}${INMATES_DIR}/dtb
    install ${B}/configs/${JH_ARCH}/dts/inmate-imx8mp-evk.dtb ${D}${INMATES_DIR}/dtb

    install -d ${D}${INMATES_DIR}/kernel

    install ${B}/tools/jailhouse ${D}${JH_DATADIR}/tools
    install ${B}/tools/ivshmem-demo ${D}${JH_DATADIR}/tools
    install -d ${D}${PYTHON_SITEPACKAGES_DIR}/pyjailhouse
    install -m 0644 ${S}/pyjailhouse/*.py ${D}${PYTHON_SITEPACKAGES_DIR}/pyjailhouse
}

PACKAGE_BEFORE_PN = "kernel-module-jailhouse pyjailhouse"

FILES_${PN} += "${nonarch_base_libdir}/firmware ${libexecdir} ${sbindir} ${JH_DATADIR}"
FILES_pyjailhouse = "{PYTHON_SITEPACKAGES_DIR}/pyjailhouse"

RDEPENDS_${PN} += " \
    python3-zipp \
    python3-ctypes \
    python3-fcntl \
"

RDEPENDS_pyjailhouse += " \
    python3-zipp \
"

COMPATIBLE_MACHINE = "(qoriq|mx8)"