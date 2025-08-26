# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.10
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
  amd64=b92bea84ec974c7b6c0383b37c39259c48caac0e1da87c510728008d8c5306ca \
  386=d71eaf7cfdf01d7e91d32c64331374c9bee85448fe1a057fa654b0e44b4e9ce9 \
  arm64=c8d1472e6a9f8c1ee1a99ab70659877b78de9081b09682551ec18280ed6066f5 \
  arm_v7=2bd1366cafcdb22b35bbe0b7207dee30ed56bfa3c941f67946769451c8da6284 \
  arm_v6=31fc62e1c59ad94d324b5913106ce48922b681748f85115a7eba871cfa32aa19 \
  arm_v5=6a1cde6c5e4f4d2b312530a41d960fb1d38b59e7ffb481755b2a56dc3d5865bb \
  mips_softfloat=b77648ce47b3c7f4b8ded49c4c5a5895429c70f89b60c641c43cf3aafb79d34e \
  mipsle_softfloat=5e5452686c498f7db3d1ac086fa035c4ea821afb5dbc30307f5f7185bf02ceca \
  mips64=e9a3a1f6443d539f9aae62e39e4518f6d9a999f1731e96e8379492609c2cdd9f \
  mips64le=0caa11f6fc1ebc4b79158bc1b208dab3adff37bddc0b9c5715914fd7701cff8c \
  loong64=ec639e7e8ad0b00d8c342d277b87b35f647218c3fdc1c3afd41e8d696be3f766 \
  riscv64=02d2dfeb3b70779b3de4e4045ebfd46c039716815fd6e3007845a8caca0c29d6
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
