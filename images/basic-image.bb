SUMMARY = "A basic console image for the overo"
HOMEPAGE = "http://www.jumpnowtek.com"

IMAGE_FEATURES += "package-management"
IMAGE_LINGUAS = "en-us"

inherit image

CORE_OS = " \
    openssh openssh-keygen openssh-sftp-server \
    packagegroup-core-boot \
    tzdata \
"

EXTRA_TOOLS = " \
    bzip2 \
    dosfstools \
    e2fsprogs-mke2fs \
    ethtool \
    findutils \
    grep \
    ifupdown \
    iperf3 \
    iproute2 \
    iptables \
    less \
    ntp ntp-tickadj \
    procps \
    sysfsutils \
    util-linux \
    util-linux-blkid \
"

SYSTEMD_STUFF = " \
    systemd-analyze \
    systemd-bash-completion \
"

IMAGE_INSTALL += " \
    ${CORE_OS} \
"

export IMAGE_BASENAME = "basic-image"
