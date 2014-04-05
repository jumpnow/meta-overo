SUMMARY = "A development image with Qt embedded and some Syntro apps"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

require console-image.bb

PR = "0"

FORTRAN_TOOLS = " \
    gfortran \
    gfortran-symlinks \
    libgfortran \
    libgfortran-dev \
 "

IMAGE_INSTALL += " \
    ${FORTRAN_TOOLS} \
 "

export IMAGE_BASENAME = "fortran-image"

