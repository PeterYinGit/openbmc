FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit systemd

SRC_URI += "file://system-power-initialize \
            file://system-power-initialize@.service \
            file://multi-gpios-sys-init \
            file://multi-gpios-sys-init.service \
            file://plat-phosphor-multi-gpio-monitor.json \
            file://plat-phosphor-multi-gpio-presence.json \
            file://phosphor-multi-gpio-monitor.conf \
            "

RDEPENDS:${PN}:append = " bash"

FILES:${PN} += "${systemd_system_unitdir}/*"

SYSTEMD_SERVICE:${PN} += " \
    system-power-initialize@.service \
    multi-gpios-sys-init.service \
    "

do_install:append() {
    install -d ${D}${datadir}/phosphor-gpio-monitor
    install -d ${D}${systemd_system_unitdir}/
    install -d ${D}${libexecdir}/${PN}

    install -m 0644 ${UNPACKDIR}/plat-phosphor-multi-gpio-monitor.json \
                    ${D}${datadir}/phosphor-gpio-monitor/phosphor-multi-gpio-monitor.json
    install -m 0644 ${UNPACKDIR}/plat-phosphor-multi-gpio-presence.json \
                    ${D}${datadir}/phosphor-gpio-monitor/phosphor-multi-gpio-presence.json

    install -d ${D}${systemd_system_unitdir}/
    install -m 0644 ${UNPACKDIR}/*.service ${D}${systemd_system_unitdir}/

    install -d ${D}${libexecdir}/${PN}
    install -m 0755 ${UNPACKDIR}/multi-gpios-sys-init ${D}${libexecdir}/${PN}/
    install -m 0755 ${UNPACKDIR}/system-power-initialize ${D}${libexecdir}/${PN}/

    install -d ${D}${systemd_system_unitdir}/phosphor-multi-gpio-monitor.service.d
    install -m 0644 ${UNPACKDIR}/phosphor-multi-gpio-monitor.conf \
        ${D}${systemd_system_unitdir}/phosphor-multi-gpio-monitor.service.d/phosphor-multi-gpio-monitor.conf
}
