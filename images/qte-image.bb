SUMMARY = "A development image with Qt embedded and some Syntro apps"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

require console-image.bb

PR = "0"

QT_TOOLS = " \
    qt4-embedded \
    qt4-embedded-dev\
    qt4-embedded-plugin-mousedriver-tslib \
    tstracker \
 "

SYNTRO = " \
    syntrocore \
    syntrocore-dev \
    syntrolcam \
    syntrolcam-init \
 "

TS_TOOLS = " \
    tslib-calibrate \
    tslib-conf \
    tslib-tests \
 "

IMAGE_INSTALL += " \
    ${QT_TOOLS} \
    ${SYNTRO} \
    ${TS_TOOLS} \
    psplash \
 "

export IMAGE_BASENAME = "qte-image"

