This layer depends on:

    URI: git://git.yoctoproject.org/poky.git
    branch: langdale

    URI: git://git.openembedded.org/meta-openembedded
    branch: langdale

    URI: git://git.yoctoproject.org/meta-security.git
    branch: langdale

Latest commits:

    poky deba71a1f2
    meta-openembedded e7c754778
    meta-security 2aa48e6

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
