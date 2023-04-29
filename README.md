This layer depends on:

    URI: git://git.yoctoproject.org/poky.git
    branch: langdale

    URI: git://git.openembedded.org/meta-openembedded
    branch: langdale

    URI: git://git.yoctoproject.org/meta-security.git
    branch: langdale

Latest commits:

    poky 3e95f268ce
    meta-openembedded 3d1ec70ed
    meta-security d10f6f9

meta-overo layer maintainer: Scott Ellis <scott@jumpnowtek.com>


NOTE: The default config for the 6.1 kernel in this repo has most protections
      intentionally disabled. The purpose is to create an easily exploitable
      arm32 Linux system.

      Use another kernel defconfig if you are using this repo for something
      important (bitbake -c menuconfig virtual/kernel)

Some more security disabling can be done by modifying /etc/sysctl.conf

    ...
    fs.protected_hardlinks = 0
    fs.protected_symlinks = 0

    kernel.randomize_va_space = 0
