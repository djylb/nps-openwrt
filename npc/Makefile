# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.4
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
  amd64=c2bd123fa47cbf5e916a12b9d4e7400a32854d5bb46a5f7177e6ac7354487f0c \
  386=dd767971c081dc6e9518d988adfe00e77280c53fa80ed2d65b4257dae783bf19 \
  arm64=ca8704fc97e24dc98c3cbb243988c1bac6632e227a8e0654188fee9725ffc131 \
  arm_v7=669a3ebaf036be125ebfbf072c4c2def480084be8b111069e0a5b67605bb4461 \
  arm_v6=d8273f60561f7107b73cfdbb77864be21ac0d170aeae5043f76673ba43fb2dc2 \
  arm_v5=1a6d3208f1f65a65b920cd2282f7662c19f200b79fc9a09f0b1ce5d8e2503ec5 \
  mips_softfloat=bdde0d44fd7485a69154929d6c976ad6c9886ddb10891c7faea79ea555f630a5 \
  mipsle_softfloat=61e7ffdcde79b478ec9d8e05b957d499f9d64f64f67182986f84fc392996137f \
  mips64=f24c248bd616a9074fa5ba2566e9998a42f8c3c0662f76eaa4df4fcc22b736d3 \
  mips64le=da9542a0fcd5416a73cdcea1991b3e6fcfcb8447f418faeb6f1630458f4efb32 \
  loong64=82cb271a49ab256e86eb6d805d7c67019f67c77b289dc45f3733c45a25c2fd9b \
  riscv64=9a66cb1a323c2553a9cbc48f2ad39045f51caf0a01e87ec20737322ab4dd8b2c
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
