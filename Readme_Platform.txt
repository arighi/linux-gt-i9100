How to build platform

1. Get android open source.
    : version info - Android gingerbread 2.3.4
    ( Download site : http://source.android.com )

2. Overwrite modules that you want to build.
 - \external\webkit  : Delete this source tree at Android gingerbread and then copy & execute "clean build".
 - \external\libjpega, \external\libexifa : Write "libjpega \" and "libexifa" into "build\core\user_tags.mk" so that add these modules.

3. Copy the files to original Gingerbread source tree (overwrite) and then make

4. Add the following lines at the end of build/target/board/generic/BoardConfig.mk

BOARD_USES_ALSA_AUDIO := true
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BT_ALT_STACK := true
BRCM_BT_USE_BTL_IF := true
BRCM_BTL_INCLUDE_A2DP := true
BOARD_USES_ALSA_AUDIO := true

5. build
- ./build.sh user
