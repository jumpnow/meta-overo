This layer depends on:

    URI: git://git.yoctoproject.org/poky.git
    branch: honister

    URI: git://git.openembedded.org/meta-openembedded
    branch: honister

    URI: git://git.yoctoproject.org/meta-security.git
    branch: honister

Latest commits:

    poky 0fbf414b39
    meta-openembedded 0fb490a08
    meta-security fb77606

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
