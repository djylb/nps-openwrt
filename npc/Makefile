# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.29
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
  amd64=0a001fe7a7799ed09fb77d5da5d25bcef0633fec4d733d7425824f662eec1a8d \
  386=d924df28d7f2d327738383e4cc9a3b7f980b743e2164194cf43ab324bcf89260 \
  arm64=819916f6f3767a79c85fa7484c1c7b318307c00e6cfbee70b1c13f1a1a42284b \
  arm_v7=9413586876ff055ef7213d95fb9d262b52e77d4aaaff33cb4672fd690db2f35b \
  arm_v6=a026ef091beaf513be2a069ebb49f772ae07bfadb26bb284ec0df2abcbb2e8b8 \
  arm_v5=259e3e99b12e16d9a4b4ebf8d3bed4cd683b29798b52be54354b5da89f41b2e0 \
  mips_softfloat=b01d616a486f679be8f2b4b65b8cfb342875b6c7c52658d650046aaeccbb55e1 \
  mipsle_softfloat=3813fee4ff5e1d7c22a86645d1ee80dc8cc94cfee079910bea1d970dc7867703 \
  mips64=cd1b622371d4348b30b7e3a80bdacc3d86088023198562006e0bf0b1feab899a \
  mips64le=1efbb31047c80e89f0385eadd6a3019a796123b8b904175f2aea71e49038f4e4 \
  loong64=dc2d5d9a1a8a431ea042c824185d30a8272510dc4d242f190412651180525c87 \
  riscv64=90efa36b9560678ba600ca52ee507bff8a1c28f00a3fe820aa5b4f9202788c87
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
