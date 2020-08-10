#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
#           (C) 2017 The LineageOS Project
#           (C) 2018 The Omnirom Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -e

export INITIAL_COPYRIGHT_YEAR=2020

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

OMNI_ROOT="$MY_DIR"/../../..

HELPER="$OMNI_ROOT"/vendor/omni/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$OMNI_ROOT" true

# Copyright headers and common guards
write_headers "rog3 zenfone7"

write_makefiles "$MY_DIR"/proprietary-files.txt
write_makefiles "$MY_DIR"/proprietary-files-product.txt

write_footers

# Reinitialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$OMNI_ROOT"

# Copyright headers and guards
write_headers

for BLOB_LIST in "$MY_DIR"/../$DEVICE/proprietary-files*.txt; do
    write_makefiles $BLOB_LIST
done

write_footers