# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.47
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
	NPC_ARCH:=mipsle
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips
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
  amd64=da25ea7f68e5fd80f757d65f8ee9ebca2f5d3507bd844f292655ecdaff44d6c4 \
  386=cb993cf2431539d48c067de96986ffa493307fc64e8e97857e510f34e54097a6 \
  arm64=3ff6bfbe842e01e49d1930bc36ade41b061cca9acc0b1ebef3f865a692d4e43d \
  arm_v7=08edf644d906ea5a009e31632cc0c56155d6a0b96f2e11f1fe09eec55eec9c7a \
  arm_v6=1be79b7730a47362e24922e1aae86a839acf7c9320c9fee0fbc8f4b258138212 \
  arm_v5=cfe2a8b0ed663d73dd5dc10b8dc95f4d8ea6d66daecb806ca5f83f776afaa85c \
  mips=b3f8f2f4fd92a2f35005d18aec06c7869c06b847d35d1d649febcb94581b700d \
  mipsle=fae79f27430e8a53733c6d234eb21faf1275b3546ed44fac97b2dcafa1a30182 \
  mips64=9d5d3899e524fe7189d76611ec5e64d8944d963523dc4ab1800529ea7b648957 \
  mips64le=33a81721854e33fc0bced8fad6585850b04242211b718100fbc7682697975982 \
  loong64=b113bd21daf56fbdf827669b21c7e1676578a27659d64c79d7238fbda1d786f0 \
  riscv64=6db476b0da1f88215db829b2eee6e27ac527623630e4af4d9f76e5c5feda63be
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
