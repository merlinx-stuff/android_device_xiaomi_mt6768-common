#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/xiaomi/mt6895-common

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    system \
    system_ext \
    product \
    vendor \
    vendor_dlkm \
    odm \
    odm_dlkm \
    boot \
    vendor_boot \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    dtbo

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Boot Image
BOARD_KERNEL_BASE         := 0x3fff8000
BOARD_KERNEL_OFFSET       := 0x00008000
BOARD_KERNEL_PAGESIZE     := 4096
BOARD_RAMDISK_OFFSET      := 0x26f08000
BOARD_KERNEL_TAGS_OFFSET  := 0x07c88000
BOARD_DTB_OFFSET          := 0x07c88000
BOARD_BOOT_HEADER_VERSION := 4

BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# base and pagesize are usually ignored when BOARD_USES_GENERIC_KERNEL_IMAGE is true,
# but our bootloader is fussy and cares about these offsets being set correctly.
BOARD_MKBOOTIMG_ARGS := --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2

BOARD_BOOTCONFIG := androidboot.selinux=permissive

# Bootloader
TARGET_NO_BOOTLOADER := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/xiaomi/mt6895
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-gnu-
TARGET_KERNEL_CONFIG := \
	gki_defconfig \
	vendor/xiaomi_mt6895.config \
	vendor/$(PRODUCT_DEVICE).config

BOARD_KERNEL_IMAGE_NAME := Image.gz

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # 4096 * 64 (pagesize)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 33554432
BOARD_USES_METADATA_PARTITION := true

# Partitions - Dynamic
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 4559208448

BOARD_MAIN_PARTITION_LIST := \
    system \
    system_ext \
    product \
    vendor \
    odm \
    vendor_dlkm \
    odm_dlkm

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
TARGET_BOARD_PLATFORM := mt6895
BOARD_HAS_MTK_HARDWARE := true
BOARD_VENDOR := xiaomi

# Recovery
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/init/fstab.mt6895
TARGET_USERIMAGES_USE_F2FS := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := product system_ext system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VBMETA_VENDOR := vendor odm
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 3

# VNDK
BOARD_VNDK_VERSION := current

# Inherit the proprietary files
include vendor/xiaomi/mt6895-common/BoardConfigVendor.mk
