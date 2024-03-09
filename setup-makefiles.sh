#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper for common
setup_vendor "${DEVICE_COMMON}" "${VENDOR_COMMON:-$VENDOR}" "${ANDROID_ROOT}" true

# Warning headers and guards
write_headers "aristotle plato xaga"

# The standard common blobs
write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers

if [ -s "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false

    # Warning headers and guards
    write_headers

    # The standard device blobs
    write_makefiles "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" true

    if [ "${TARGET_TEE}" == "beanpod" ]
    then
      write_makefiles "${MY_DIR}/../../${VENDOR_COMMON}/${DEVICE_COMMON}/proprietary-files-beanpod.txt" true
    elif [ "${TARGET_TEE}" == "mitee" ]
    then
      write_makefiles "${MY_DIR}/../../${VENDOR_COMMON}/${DEVICE_COMMON}/proprietary-files-mitee.txt" true
    fi

    if [ -f "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-firmware.txt" ]; then
        append_firmware_calls_to_makefiles "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-firmware.txt"
    fi

    # Finish
    write_footers
fi
