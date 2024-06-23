#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),$(filter $(TARGET_DEVICE),rog3 zenfone7))
    subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
    $(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))

include $(CLEAR_VARS)
IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

include $(CLEAR_VARS)
SYSHELPER_LIBS := libsystemhelper_jni.so
SYSHELPER_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS)/com.qualcomm.qti.services.systemhelper/lib/arm64/,$(notdir $(SYSHELPER_LIBS)))
$(SYSHELPER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "System Helper lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYSHELPER_SYMLINKS)

WFD_LIB := libwfdnative.so
WFD_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/WfdService/lib/arm64/,$(notdir $(WFD_LIB)))
$(WFD_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WFD lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@
ALL_DEFAULT_INSTALLED_MODULES += $(WFD_SYMLINKS)

FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(BT_FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT)

ASUSFW_MOUNT_POINT_SYMLINK := $(TARGET_OUT_VENDOR)/asusfw
$(ASUSFW_MOUNT_POINT_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $@ link"
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/$(notdir $@) $@

FACTORY_MOUNT_POINT_SYMLINK := $(TARGET_OUT_VENDOR)/factory
$(FACTORY_MOUNT_POINT_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $@ link"
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/persist $@

ALL_DEFAULT_INSTALLED_MODULES += $(ASUSFW_MOUNT_POINT_SYMLINK) $(FACTORY_MOUNT_POINT_SYMLINK)

endif