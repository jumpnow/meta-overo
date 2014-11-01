## Upgrading from [daisy]

### bblayers.conf

*meta-openembedded/meta-networking* now has a dependency on *meta-openembedded/meta-python*

### Package upgrades

openssh `6.5p1` to `6.6p1`
qt4 `4.8.5` to `4.8.6`
wpa_supplicant `2.1` to `2.2`

### task-core-openssh was removed

Replace with `openssh` in *console-image*.

