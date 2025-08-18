# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.7
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
  amd64=08735503f526a7b34decd298cf957b246647c22fe2c9f8fcc6a9988711934224 \
  386=a7524be35c2f4a120622aecbb38712ed7549654aa5c6e60bf911d577428c1032 \
  arm64=805857c85341c1b78c7d1d7625d3821ea141dc025885fcd86bc098f3a290cf22 \
  arm_v7=36b80813992b76236731263972cfca84a5ef03d358cca0d56ed96df1df7005d4 \
  arm_v6=218f61cfcd341c836eb8c70659c45e706b5fa875edd0da8d615fd02c93f08edc \
  arm_v5=734f20739d02d2246dda4b8f2b46c31747495d93201a2b413d5ae2d4c716852e \
  mips_softfloat=af8e46c843f4fe5cabc560494531b3cd8ffb775ed505b3ed598e217282cc48a5 \
  mipsle_softfloat=f07e15367a9242b73b695bb8488074c7505ccaf4fb247dae2db8da769772dca1 \
  mips64=fd2da0681ab4f944281ffc7667754153bdb77f260f2d3fd00fe0f83a0ce7053a \
  mips64le=4efa0c8bd8997b99492d96f96d9108f9ad034f888ea5b7b75cdf30ecda1eef84 \
  loong64=5f5069d2783ab1e6a26378128e347edb938b11eab7f7e0762f0c71ec28fb5374 \
  riscv64=4f68ea33b452e8e0f5820cb8175dbde1aa2f1e5d696b241084358a3d9a79bedf
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
