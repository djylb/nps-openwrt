# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.3
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
  amd64=9d0c4a43aba1d51a902d9ea5a7b6370e4e822a6b747fedb8837f03265997d199 \
  386=3216f387875f117141392f9692ab0159d2b5b9055ac3ac7ea27c83ea427ec638 \
  arm64=ae2ceb74a0a220dc07b365860562cfd73900520b4bf6c204abf8f87efc7f712b \
  arm_v7=f57f7407b0cfb1a61474b6f6474002091298ea4a72db08d8926cd0e9af8076c6 \
  arm_v6=e7d48e5f622e105342ba0771ae176cdc708d113261849a382a0e2e9e7ef2791c \
  arm_v5=bfa849b41da4b8e2e99c8cf73f5373136ac0e005a779f05447b9f3c5827873d3 \
  mips_softfloat=e1c8577caa62689d4472523728f3c9d081cb58eb9fbfc796fa71b70ea08314a1 \
  mipsle_softfloat=4abc6d8805bea9503722bb5928e77ef3c71bb0058a5753dd8d4bae347173d294 \
  mips64=6d6bcad5abdc44930e4384c12e6df3c61829c410aa15dedafdf40943d64fe94b \
  mips64le=7f19ad0d5c2126fe2e34d4c07afe6cf1bb2dec26816d6bbaf7178d144d30b17f \
  loong64=db57a290d7f42fd2fc8285b71869e3e7348d02e4ef8fedee6b4a1de53188acca \
  riscv64=7a92c20364264d0dc2f027da086ee05a8d0feba9994c332ec97bc3c9e99dddc8
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
