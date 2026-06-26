FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://optic.cfg "
SRC_URI += "file://fmc-wdt2-timer.cfg "
SRC_URI += "file://0500-ARM-Aspeed-add-a-config-for-FMC_WDT2-timer-reload-va.patch"