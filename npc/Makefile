# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.0
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
  amd64=6e545b43d17ae1fea575dcc99286948b8c9d71e1934da2223dcf78306c0713b0 \
  386=c9a0f3957663ece78806eb93380ad604179aa0df071bc083f7463bac992f60fb \
  arm64=c8f634ae5c1b3383cf23b38b3b348505a68283c73c214c7661a9a8b94c8c103e \
  arm_v7=5a06d61f3918dbef8d1f7bd515b5b0e59807a664b0e4db4c001511b11c73cdc2 \
  arm_v6=b7ed371e7baffdc1de1b7333f49cc02838156ca5dba5cea9f9137434f845f116 \
  arm_v5=bac4e5ce8fe77336ba55b49d6863cf03f5e7c3b73978487a1561e8ba0830fe6b \
  mips=ec72f69e9ca1a2d01d2a822496547ff2752aa214345a020e720b2e2428ee8450 \
  mipsle=ece098caacc67419df3ffa32f3f445a55582f72256d69adb27d25353af10c90f \
  mips64=d899d415026b6f8c5e5a7a7857e3fb494ee63c31066dd8d4e95b00d9dd5c6a3d \
  mips64le=08b907c788a399a53d5ce891e34b113deace4ee60f21a1c66e852dfc57c2c575 \
  loong64=c315abd2b4443ac27cafffd6557b8215073a3f7ccfadc00c622790102cded766 \
  riscv64=7d931a7f2cad6da8e96cbeb9b0a96c7901df16ac80a9c898cb6da638978ef0e7
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
