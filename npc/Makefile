# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.35.1
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Duan <duan@d-jy.net>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

NPS_URL=https://github.com/djylb/nps

NPC_ARCH:=
ifeq ($(ARCH),x86_64)
	NPC_ARCH:=amd64
endif
ifeq ($(ARCH),i386)
	NPC_ARCH:=386
endif
ifeq ($(ARCH),aarch64)
	NPC_ARCH:=arm64
endif
ifeq ($(findstring armv8,$(BOARD)),armv8)
	NPC_ARCH:=arm64
endif
ifeq ($(ARCH),arm)
	ifeq ($(BOARD),bcm53xx)
		NPC_ARCH:=arm_v6
	else ifeq ($(BOARD),kirkwood)
		NPC_ARCH:=arm_v5
	else
		NPC_ARCH:=arm_v7
	endif
endif
ifeq ($(filter mipsel,$(ARCH)),mipsel)
	NPC_ARCH:=mipsle_softfloat
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips_softfloat
endif
ifeq ($(filter loongarch64,$(ARCH)),loongarch64)
	NPC_ARCH:=loong64
endif
ifeq ($(filter riscv64,$(ARCH)),riscv64)
	NPC_ARCH:=riscv64
endif

PKG_SOURCE:=linux_$(NPC_ARCH)_client.tar.gz
PKG_SOURCE_URL:=$(NPS_URL)/releases/download/v$(PKG_VERSION)/

# === NPC_HASH_TABLE_START ===
NPC_HASHES:= \
  amd64=e99b7b107ab977eb7f06158b5e2cec3b48738ae56422f2fb4c7f501ca9c4326f \
  386=f4a4077adc1147f1b8e4a25e5fa59e865ea1623b9d15a68e750148e3917c43de \
  arm64=494da5300f8a3c383a4b547e46d993a75a2a30a491cf1c3bcf4befb22faf5440 \
  arm_v7=f459f90d0afca8f584afedabc661a3bfa3dd01a17f3215eaf4a5be55cf2fcd84 \
  arm_v6=d1a7d491a994e73a3e51ff295975e0a40b42e7f44860fa52b5672a01321a0c51 \
  arm_v5=2951b68844e397398729f476f2676bacb17592c318c959cae9d22dffe143f5fd \
  mips_softfloat=ff8bb77bac1244c6a139959e92a7cf15bf51a63644279915cf5a4f405e23180e \
  mipsle_softfloat=30f37cca83bffd31c2eed9e06788fa5b6429179d9a80830535d994a3d8004721 \
  mips64=72aa555885dc2d529b188acf46b490cc34aaf5cb7d8920e9c00b81056569c976 \
  mips64le=4a5162a7e199a310951ac860177ee8d4f74ea8820924226a96cbae3f79ff0019 \
  loong64=07ab60b8a5874c46fb3e1f36c34b6bffa0702c06c7b705b1f0d0138af69cb801 \
  riscv64=97410280d17bcca5a8ee5ecb24d7256cddac03bb6c27582743a9029ff9bba02f
# === NPC_HASH_TABLE_END ===

PKG_HASH:=$(strip $(foreach pair,$(NPC_HASHES), $(if $(findstring $(NPC_ARCH),$(pair)),$(word 2, $(subst =, ,$(pair))))))

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=NPC Client (precompiled for $(NPC_ARCH))
	URL:=$(NPS_URL)
endef

define Package/$(PKG_NAME)/description
NPC is a fast reverse proxy client to expose local servers through NAT/firewall.
This package uses the precompiled binary for the $(NPC_ARCH) architecture.
endef

define Build/Compile
	mkdir -p $(PKG_BUILD_DIR)
	tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/$(PKG_NAME)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
