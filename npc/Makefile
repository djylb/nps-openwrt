# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.8
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
  amd64=c19aaf563ce9e21dd0fd801b4f27e705f707086c84a81dc87813fc15e81bfffe \
  386=e64d9f3f034541f003c6a0732137b18ffaa3967ae650fe14fae91d588143fb37 \
  arm64=4154f60eba6e56095c1424a6fba1e0a983ef07778572471fd00c7528580dbc83 \
  arm_v7=9c6ceda414b2615f43ed31abffeb391a9a1d69486d1a2bf017bb98fd0219c29b \
  arm_v6=3faab6687cfc1a47731da706f3171ff1917e51a01c00db7a538d10116ef476ad \
  arm_v5=b3e9a5d012f4c20db3595508e3ce8b90fa08b9bc2b52f74221d5bd1fa91e7c8a \
  mips_softfloat=5834cd9a13aa034f24f4fe285547dcacfbce8ead8454e63688c9a90d53aeea44 \
  mipsle_softfloat=92d9993096e5dfea05bd2016c61256059931eec7cee1811922378d477b4146b6 \
  mips64=eec5fd251aa734d40b023cfca02e58e7e62ecb33adc0ce67e1d98c1fbdacebd7 \
  mips64le=ebe382ffc97520ef337619a81bd3a6208bee3bb1363fbd47f6b03156e37a877c \
  loong64=c29c72509c16cf6a5ef8acda9017d1883d3fd640c472aec013544c1251c74a84 \
  riscv64=aac86b58947934305800d474f68548546e7a030e8a709b903844040dec326fbb
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
