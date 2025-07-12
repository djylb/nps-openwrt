# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.35
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
  amd64=8039e955ecb0893ae111a31649468b7b9b877cbb843865db25fb3c96e7eede68 \
  386=2a1797601f4cf1ac5e7ea1a6d7ed0cebcdbdf4a85396bb00cc48c01e047c1ddb \
  arm64=15d2329cdd746e55e022ef60e5feed7f77bb96f7c064c0ae9c99590ed040f888 \
  arm_v7=eb38498efa4ff5ffcf6ff9084b06090adf9c19d071a698c8fa71b4e97eb29863 \
  arm_v6=ccd243a6b8eeef14f5994fc3e23f899ce609c9a27dea7445e47b9b933cbd4ad3 \
  arm_v5=bdb905ae8874c65bbc637456b270f473a76f2f909a3e0d547b89daa23efc0e06 \
  mips_softfloat=b2344ee8042d03a4ee019a3356446ba8fcb8f569f49395241b7e985f7cc6c630 \
  mipsle_softfloat=6788f336078909f2510ad07c9729cc81f54d7024ab879002dd385d3760784b9f \
  mips64=26ee1851b95041eec0fe708d4aec4de4dbe461e00182ea8a2ed7c67c98953e8d \
  mips64le=a4375abd2da0b797307d4857ce9f870c2adee31426534ebed2d9ce6131db7a6d \
  loong64=fc084a46838de3445dace157b2457b3bbf2853ccd17d4310d73fea595d2546d4 \
  riscv64=2ac101787047b22ab7e2bc4c92cc34188c7189a40cd7e9a8a963fa1c33f3d26a
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
