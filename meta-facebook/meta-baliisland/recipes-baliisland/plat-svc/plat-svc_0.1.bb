SUMMARY = "Baliisland Platform Early System Initialization Service"
DESCRIPTION = "Provides early system initialization, standby power enablement, \
and I2C mux/expander binding for the Baliisland platform."
SECTION = "base"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch
inherit systemd
inherit obmc-phosphor-utils

S = "${UNPACKDIR}/sources"

RDEPENDS:${PN} += "bash"
RDEPENDS:${PN} += "libgpiod-tools"
RDEPENDS:${PN} += "fb-common-functions"

SRC_URI:append = " \
    file://platform-early-sys-init \
    file://device-initialize \
    file://platform-sys-init.service \
"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN}:append = " \
    platform-sys-init.service \
"

FILES:${PN} += " \
    ${systemd_system_unitdir}/platform-sys-init.service \
"

do_install() {
    # Install initialization scripts
    PLATSVC_LIBEXECDIR="${D}${libexecdir}/plat-svc"
    install -d ${PLATSVC_LIBEXECDIR}
    install -m 0755 ${UNPACKDIR}/platform-early-sys-init ${PLATSVC_LIBEXECDIR}
    install -m 0755 ${UNPACKDIR}/device-initialize ${PLATSVC_LIBEXECDIR}

    # Install systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UNPACKDIR}/platform-sys-init.service ${D}${systemd_system_unitdir}
}
