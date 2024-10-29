#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit our proprietary vendor
$(call inherit-product, vendor/xiaomi/yunluo/yunluo-vendor.mk)
