This layer depends on:

        URI: git://git.yoctoproject.org/poky.git
        branch: dora
        revision: HEAD
        commit: 609ae39 

        URI: git://git.openembedded.org/meta-openembedded
        branch: dora
        revision: HEAD
        commit: 40e0f37 

        meta-overo layer maintainer: Scott Ellis <scott@jumpnowtek.com>

#### Note

I removed the `meta-gumstix` repository.

I did so for stability reasons.

The new u-boot and kernel recipes in this layer pull from the same upstream
mainline repositories for their source and include the same patches Gumstix
was providing in their recipes. The recipes are identical for now, but they
are likely to change over time.

It's just now they won't change until I test them.

Sorry about this change, but if you were using `meta-overo` my
suggestion is you delete

* TMPDIR
* sstate-cache
* cache

and build again.

Make sure to look at the latest `conf/local.conf-sample` and
`conf/bblayers.conf-sample` and update your versions accordingly.

If this is your first build, it's no problem.

More instructions can be found at [jumpnowtek.com][overo-yocto-build]

[overo-yocto-build]: http://www.jumpnowtek.com/gumstix/overo/Overo-Systems-with-Yocto.html

