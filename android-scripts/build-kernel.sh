#!/bin/bash

TOPDIR=`pwd`
OUTPUT=/tmp/galaxy-i9100-kernel-gingerbread-arighi.tar
CONFIG=$TOPDIR/.config
TMP_INITRAMFS=/tmp/initramfs
MAKE_OPTS=

# configure
if [ ! -e $CONFIG ]; then
	make ARCH=arm CROSS_COMPILE=arm-none-eabi- c1_rev02_defconfig
fi

# make modules
make ARCH=arm CROSS_COMPILE=arm-none-eabi- modules_prepare
make ARCH=arm CROSS_COMPILE=arm-none-eabi- modules

# generate initramfs
if [ -e ../initramfs/ ]; then
	rm -rf $TMP_INITRAMFS $TMP_INITRAMFS.cpio

	rsync -avHS --exclude=.gitignore --exclude=.git ../initramfs/ $TMP_INITRAMFS
	find -name '*.ko' -exec cp -av {} $TMP_INITRAMFS/lib/modules/ \;

	cd $TMP_INITRAMFS
	find | fakeroot cpio -H newc -o > $TMP_INITRAMFS.cpio 2>/dev/null
	ls -lh $TMP_INITRAMFS.cpio
	cd -

	MAKE_OPTS="$MAKE_OPTS CONFIG_INITRAMFS_SOURCE=$TMP_INITRAMFS.cpio"
fi

# make kernel
make ARCH=arm CROSS_COMPILE=arm-none-eabi- $MAKE_OPTS

# prepare kernel to be flashed by Odin
cd arch/arm/boot
tar cf $OUTPUT zImage && ls -lh $OUTPUT
