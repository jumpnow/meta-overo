SUMMARY = "Gumstix Overo bluetooth hciattach scripts for systemd systems"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

PR = "r0"

SRC_URI = " \
    file://99-bluetooth-via-uart.rules \
    file://bluetooth-ttyO1-csr.service \
    file://bluetooth-ttyO1-wilink.service \
 "

SYSTEMD_SERVICE_${PN} += "bluetooth-ttyO1-csr.service \
                          bluetooth-ttyO1-wilink.service \
 "

S = "${WORKDIR}"

do_install() {
    install -d ${D}${systemd_unitdir}/system
    install -m 755 bluetooth-ttyO1-csr.service ${D}${systemd_unitdir}/system
    install -m 755 bluetooth-ttyO1-wilink.service ${D}${systemd_unitdir}/system}

    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-bluetooth-via-uart.rules ${D}${sysconfdir}/udev/rules.d
}

FILES_${PN} += "${systemd_unitdir} ${sysconfdir}"
