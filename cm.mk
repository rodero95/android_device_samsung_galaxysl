## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := SGSL

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/galaxysl/full_galaxysl.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := galaxysl
PRODUCT_NAME := cm_galaxysl
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := GT-I9003

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=GT-I9003 BUILD_ID=JSS15Q BUILD_DISPLAY_ID=JSS15Q BUILD_FINGERPRINT="samsung/GT-I9003/GT-I9003:4.3/JSS15Q/779366:user/release-keys" PRIVATE_BUILD_DESC="GT-I9003 4.3 JSS15Q 779366 release-keys"
