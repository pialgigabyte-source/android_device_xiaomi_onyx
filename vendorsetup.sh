#!/bin/bash

echo 'Cloning Hardware Tree'
        git clone https://github.com/xiaomi-sm8750-onyx/android_hardware_xiaomi.git -b lineage-23.2 hardware/xiaomi

echo 'Cloning Prebuilt Kernel Tree'
	git clone https://github.com/xiaomi-sm8750-onyx/android_device_xiaomi_onyx-kernel.git -b lineage-23.2 device/xiaomi/onyx-kernel

echo 'Cloning Priv-keys'
	git clone https://github.com/xiaomi-sm8750-onyx/android_vendor_infinity-priv_keys.git -b lineage-23.2 vendor/infinity-priv/keys

echo 'Cloning Vendor Tree'
	git clone https://github.com/xiaomi-sm8750-onyx/android_vendor_xiaomi_onyx.git -b lineage-23.2 vendor/xiaomi/onyx

echo "vendorsetup.sh execution complete."
