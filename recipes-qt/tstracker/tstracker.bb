DESCRIPTION = "Touchscreen event tracking app for debugging Qt touchscreen"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

inherit qt4e

SRCREV = "ed45c5261c77440a90c804e29cefb86c1eede813"
SRC_URI = "git://github.com/scottellis/tstracker.git;protocol=git"

S = "${WORKDIR}/git"

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

