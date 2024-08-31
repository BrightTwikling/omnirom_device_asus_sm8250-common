# Add common definitions for Qualcomm
vendor_omni_qcom_common=$(wildcard vendor/omni/qcom/common.mk)
ifneq ($(vendor_omni_qcom_common),)
include vendor/omni/qcom/common.mk
else
include device/asus/sm8250-common/vendor/omni/qcom/common.mk
endif

# Platform
TARGET_BOARD_PLATFORM := kona
TARGET_BOOTLOADER_BOARD_NAME := kona
