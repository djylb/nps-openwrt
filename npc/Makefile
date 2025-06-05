# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.16
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
  amd64=762c865873ad0311bd764de0722b313c3f61221169c4332e40862b71d278d164 \
  386=814e52ce48f502f5a71076ca2345d6d70a1fddef0b3c41643c1c80878fe5d9ef \
  arm64=95a6e67578a1f08a60d8058260b0947c87580deec8e69b41d3485abbbd5b7ca1 \
  arm_v7=268b82c52f3541a74d5ba1e2f901f87e88d83cf6f7a4abc791d50048acdb4738 \
  arm_v6=472f9b1705ffaae59b0dd3cf8c835e0004a33a63f7ecbffa28422609f00b0c98 \
  arm_v5=138dead7d5e0f16b68b9f51eba571dd8b11c43998ec020da8fd2018fa9972260 \
  mips_softfloat=6013cb6d88781623fa92dd23c78f948445033b0aace0ac3b2ad75993a8fa9b4d \
  mipsle_softfloat=7fc72c97e217339d6d65f67ab6f0ae5e41d51b472dac9674afcd8665e7eeafa7 \
  mips64=4872f76737a52fcf2409fb679d0e95815f3e7ce492cea3d12f327ae75782b242 \
  mips64le=51a49417f3bdc358ad6030ee8120c7f9ecd37fd643b25127ef1247de1752f017 \
  loong64=4283ae875d4cd6303fa3e53de118dd9fa400eb2f65876dbaba5e0cdbe57098a2 \
  riscv64=4132b98e31739b4d8a2f048be8a6953a523efbc7375a63c2a8f47ca7a233710f
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
