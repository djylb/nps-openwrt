# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.51
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
  amd64=008d1a1b2892d32cfc844fef70657a6d59636edea23c79247641873149ef25f4 \
  386=55a28c38d5180326aefcc4a94db56e5ea31e4532b52f9804c2508db935a51237 \
  arm64=f4e9a2cfd9f2a57e08e8da37a05f67a8728b0c5d7a4e15fdf03fc50c31af3cc1 \
  arm_v7=0ddb5dd7e6aedb5e4a80235cfcfb381b622aa32caf2bfac596c113a6e0cfba9a \
  arm_v6=d9deeb82619571d5f14084b57fcadd4cc7465904fe43bfb1909dfdb62c4ef1ff \
  arm_v5=9eff73883a0a36bfa97654956774d0ad571188e93e0484c364d15538c58bc73c \
  mips=4d1f2f4ce9c3c75ea0c18a952a10dcf1bcb680131b36e39b6bfdc31825ffdcb0 \
  mipsle=152cd130b1ce020eaf1ab6dc4783db88760ebd926726354aff6a506f8fc42cdf \
  mips64=cca305a413c36e25c1ba7fdc452b566d2314b603c50c65bebe000cbea7dea820 \
  mips64le=9cbfbdbc5a38b6a8ed54258742f99970c3cc0b969fae8a63cb03030ffe8ffcfd \
  loong64=718e0863639280285ddf3514e0aba0a67922f5409be3bc00fe6d2d0fb9f4e603 \
  riscv64=efc820a33a3acd680d2c2616b55065cc0cb85881a9f3b1ec68a7070d443adf3a
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
