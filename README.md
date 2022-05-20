This layer depends on:

    URI: git://git.yoctoproject.org/poky.git
    branch: kirkstone

    URI: git://git.openembedded.org/meta-openembedded
    branch: kirkstone

    URI: git://git.yoctoproject.org/meta-security.git
    branch: kirkstone

Latest commits:

    poky 453be4d258
    meta-openembedded 166ef8dbb
    meta-security 93f2146

meta-overo layer maintainer: Scott Ellis <scott@jumpnowtek.com>


NOTE: The default defconfig for the 5.15 kernel in this repo has most kernel
      protections intentionally disabled. The purpose is to create an easily
      exploitable arm32 Linux system.

      Use another kernel defconfig if you are using this repo for something
      important (bitbake -c menuconfig virtual/kernel)

Some more security disabling can be done by modifying /etc/sysctl.conf

    ...
    fs.protected_hardlinks = 0
    fs.protected_symlinks = 0

    kernel.randomize_va_space = 0
