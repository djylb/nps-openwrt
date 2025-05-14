# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.28.1
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
  amd64=c6fe7508bcee574d18f3dbbeb4c75c99b11bb97152ea22a4f77116f1faf05567 \
  386=ac1c28f1fa1f6bdcc7ad3c4446c8d872d93d186d7c86607f672ea9578f716670 \
  arm64=5c7e1371e63b67cad8f13be3878ae6c3fe6d4ace9af1769bc2bb48b467aed47b \
  arm_v7=79fba5baf0096e43051dce9c7f46272d4d37e6bc127f5cc523f1884ddeb10907 \
  arm_v6=07fd11c9753aa27695ec16b9bc415f7eaa8038b130d982acca040529a03bb16d \
  arm_v5=40f63378ce67f38524862083a84ead2f8f05fae5e665bbe4982746d40302c189 \
  mips=261d34fe0412a1818cc87c479bfcbd750a1c053b3dee95d931a2995655334d34 \
  mipsle=f0e9ed07abf94ab504cc225bfa014526ea3001dacccfdf05bebbb6bc25e93b8d \
  mips64=b05f17d48e838b72a970916c58f2eaf8f19525b2ba354b360366a6b5c2cdf986 \
  mips64le=845e10296e06635e75e562fc4e00eb53950f5c9d3d15361d597e759e1f02b063 \
  loong64=f27af58669da8bdc4d53e7581b45a81318352aceb6a957e09e06302ad4a8a3c5 \
  riscv64=8e4504cddb9e97e7b0077daf05395916cbdef5611e80025ee1a553c0e3e6a044
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
