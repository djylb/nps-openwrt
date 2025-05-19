# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.1
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
  amd64=eb9c404c9c0c2bd98a3de1f2fb7e801e49b8746bb2fa8a0fdce2c8458e99d6d4 \
  386=e1f44d1a58284d48409fceab2942f59ba87773627294ad4993b1b99b873b898a \
  arm64=fbe75c8f5caa2582bbde94e60c2be5bd996ce52f9443c109321679f79c6f668a \
  arm_v7=98e1139dcd00ef98f44b576721789889871b73fb0701cd300c9f1abde2903d9c \
  arm_v6=771d358f86ee5b75bd45027e9277d79535ea79c54e07689178807985d67caa0e \
  arm_v5=38a296c2fc32c7ce257ca3dd69d5f5d288009f27b2e4b447254ed4e3d6adbac5 \
  mips=41e47276a67fc9e792f5eb4da73b5e431b335bb56afc2c0c64f4f056a20b5de7 \
  mipsle=6033d86e29946f0ef41949f0ea11f6353bf92d5f1a6162aa475c5e62f9e97c53 \
  mips64=3f4fc2237572548ca094d17ecd1aaa097b4d40953dfcd57208145e8c92703441 \
  mips64le=35fc9188b8bc1ca2d4ba8d08e0f85c8d0aeb01f78671058f5df4658bedccb1d8 \
  loong64=3ba7c3eecc1a8bbdc393be1683aa0d295dd7a91704c2e6817614b46319d273b6 \
  riscv64=fe2b2acd2df4ec86b56f705d6bf85320354bb15b5084e7480d9ff05a47e9f72a
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
