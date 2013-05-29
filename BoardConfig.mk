# inherit from the proprietary version
-include vendor/samsung/galaxysl/BoardConfigVendor.mk

# Board properties
TARGET_BOARD_PLATFORM := omap3
TARGET_BOOTLOADER_BOARD_NAME := latona
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a8
TARGET_ARCH_VARIANT_FPU := neon
ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_arm_CFLAGS := -O3 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops \
                       -fmodulo-sched -fmodulo-sched-allow-regmoves
TARGET_thumb_CFLAGS := -mthumb \
                        -Os \
                        -fomit-frame-pointer \
                        -fstrict-aliasing

COMMON_GLOBAL_CFLAGS += -DOMAP_COMPAT -DOMAP_ENHANCEMENT -DTARGET_OMAP3

TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_PROVIDES_INIT_TARGET_RC := true

BOARD_NAND_PAGE_SIZE := 4096
BOARD_NAND_SPARE_SIZE := 128
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := console=ttySAC2,115200 consoleblank=0
BOARD_KERNEL_BASE := 0x10000000
BOARD_PAGE_SIZE := 4096

BOARD_CUSTOM_BOOTIMG_MK := device/samsung/galaxysl/shbootimg.mk

# Inline kernel building config
TARGET_KERNEL_CONFIG := latona_galaxysl_defconfig
TARGET_KERNEL_SOURCE := kernel/samsung/latona

# recovery
BOARD_USES_MMCUTILS := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PRE_COMMAND := "echo 1 > /cache/.startrecovery; sync;"
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/samsung/galaxysl/recovery/recovery_keys.c
BOARD_USES_BML_OVER_MTD := true

# fix this up by examining /proc/mtd on a running device
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 339738624
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2013200384
BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/usb_mass_storage/lun%d/file"

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/galaxysl

# Vibrator
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/samsung/galaxysl/vibrator/tspdrv.c

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/galaxysl/bluetooth

# Egl
BOARD_EGL_CFG := device/samsung/galaxysl/egl.cfg
USE_OPENGL_RENDERER := true

# TARGET_DISABLE_TRIPLE_BUFFERING can be used to disable triple buffering
# on per target basis. On crespo it is possible to do so in theory
# to save memory, however, there are currently some limitations in the
# OpenGL ES driver that in conjunction with disable triple-buffering
# would hurt performance significantly (see b/6016711)
TARGET_DISABLE_TRIPLE_BUFFERING := false

BOARD_ALLOW_EGL_HIBERNATION := true

# OMX Stuff
HARDWARE_OMX := true
TARGET_USE_OMX_RECOVERY := false
TARGET_USE_OMAP_COMPAT := true
BUILD_WITH_TI_AUDIO := 1
BUILD_PV_VIDEO_ENCODERS := 1

# Touchscreen
BOARD_USE_LEGACY_TOUCHSCREEN := true

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_AUDIO_LEGACY := false

# FM Radio
BOARD_HAVE_FM_RADIO := true
BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO
BOARD_FM_DEVICE := si4709

# Camera
BOARD_CAMERA_LIBRARIES := libcamera

# Wifi related defines
USES_TI_MAC80211 := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X_TI
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_wl12xx
PRODUCT_WIRELESS_TOOLS           := true
BOARD_WLAN_DEVICE                := wl12xx_mac80211
BOARD_SOFTAP_DEVICE              := wl12xx_mac80211
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wl12xx_sdio"
WIFI_FIRMWARE_LOADER             := ""
COMMON_GLOBAL_CFLAGS += -DUSES_TI_MAC80211
BOARD_HOSTAPD_TIAP_ROOT     := system/wlan/ti/WiLink_AP

WLAN_MODULES:
	make clean -C hardware/ti/wlan/mac80211/compat_wl12xx
	make -C hardware/ti/wlan/mac80211/compat_wl12xx KERNEL_DIR=$(KERNEL_OUT) KLIB=$(KERNEL_OUT) KLIB_BUILD=$(KERNEL_OUT) ARCH=arm CROSS_COMPILE="arm-eabi-"
	mv hardware/ti/wlan/mac80211/compat_wl12xx/compat/compat.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/net/mac80211/mac80211.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/net/wireless/cfg80211.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx.ko $(KERNEL_MODULES_OUT)
	mv hardware/ti/wlan/mac80211/compat_wl12xx/drivers/net/wireless/wl12xx/wl12xx_sdio.ko $(KERNEL_MODULES_OUT)
	arm-linux-androideabi-strip --strip-unneeded $(KERNEL_MODULES_OUT)/*

TARGET_KERNEL_MODULES += WLAN_MODULES

TARGET_OTA_ASSERT_DEVICE := galaxysl,GT-I9003,GT-I9003L
