FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit obmc-phosphor-utils
inherit systemd

SRC_URI:append = " \
    file://80-mctp-usb.link \
    file://99-sma-mctp-eid.rules \
    file://sma-mctp-eid-config \
    file://sma-mctp-eid-config@.service \
    "

RDEPENDS:${PN} += " bash"

FILES:${PN}:append = " \
    ${systemd_unitdir}/network/80-mctp-usb.link \
    ${systemd_system_unitdir}/sma-mctp-eid-config@.service \
    "

SYSTEMD_SERVICE_FMT = "sma-mctp-eid-config@{0}.service"
SYSTEMD_SERVICE:${PN}:append = " ${@compose_list(d, 'SYSTEMD_SERVICE_FMT', 'SMA_MCTP_INSTANCES')}"

SMA_MCTP_INSTANCES = " \
    mcu1u2u1u1 \
    mcu1u2u1u3u2u1 \
    mcu1u3u1u2u2 \
    mcu1u2u1u4u1 \
    mcu1u2u1u3u1 \
    mcu1u3u1u3u1 \
    mcu1u2u1u3u4 \
    mcu1u3u1u4u1 \
    mcu1u3u1u4u2 \
    mctpspi0_2 \
    mctppci0 \
"

do_install:append() {
    install -d ${D}${libexecdir}/mctp
    install -m 0755 ${UNPACKDIR}/sma-mctp-eid-config ${D}${libexecdir}/mctp/

    install -d 0755 ${D}${systemd_unitdir}/network
    install -m 0644 ${UNPACKDIR}/80-mctp-usb.link ${D}${systemd_unitdir}/network/

    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${UNPACKDIR}/99-sma-mctp-eid.rules ${D}${sysconfdir}/udev/rules.d/

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UNPACKDIR}/sma-mctp-eid-config@.service ${D}${systemd_system_unitdir}
}

