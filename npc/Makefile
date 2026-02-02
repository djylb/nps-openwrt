# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.0
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
  amd64=81a33ad526e81e0dca69a670b6c7273202da7549287c08e4edcf71164c7800d5 \
  386=0be297e88b903092093df981cc82352eac87b4d0f82f745c7fc46e89bbac20f8 \
  arm64=30bc402ad27b72f646bd726a90c175d42ab5082f73ecf7189dfcd37bdfbf7233 \
  arm_v7=6ff0e1dcb69be163f080d2d4e8dbdee83241e864d882dd3bf25d179fc72b2e99 \
  arm_v6=cc860fa6a2d4dbe5b028faeee80d1f3bc485e32d1c0565746f2fa5d9fafa78b2 \
  arm_v5=d10a646bf96812fc365071dfb2fa024fa6cc3428aa0e92c271a6da5cf683eaee \
  mips_softfloat=44920b0724d4e366d0e4dcce69515068ef20f5eb97ceb6397d8aad9cf02029db \
  mipsle_softfloat=efdefef4fbe28ba5de496fa7142a295fe9b59c899c3da6c10fcd8f9b264e9786 \
  mips64=4a62a3b855f612dcdac8c7ba12daf38e44c7d39a6725ff5d5bfd43ed12637385 \
  mips64le=dafec64d215babd7cad8b409585dd51f7f186661724ba2948b102e7ec54886c3 \
  loong64=7525a431b93f88fa49112aa4ae9504c748168b5ad184a1adcca7db11edc716de \
  riscv64=7abdd5026fe03d000917976290a5b2bcb7f1efd11b2350337a10c879b2a85567
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
