# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.6
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
  amd64=f8d3ec9e68cfe4686a0d3db174ef01f2aa64066d3fdf471eb4741f9b1bcc01af \
  386=6003d08981b69ebe78d201a13062b3887cb7ecdfe0b0cebeed6da205c8bcaef5 \
  arm64=3ab585991ae5e655dde38120f2f7a5ca1f9f00c5fda7b4dce81f52b8438808c1 \
  arm_v7=4ae8e58087d588ec4fd349eb492258658cf9a87c982c62d16016c16b28b385ac \
  arm_v6=c8e535e37cceb84961c8481fd85fbffcb86062ab19650814ad86915a0fc72a43 \
  arm_v5=85fda91b667edef8afeed9b2acffeecee9d1d7a55a3f6d5755f9c848b3276c98 \
  mips_softfloat=5178e8851cb320d3abf268ead566ff960d5b1563027b443997022095e1a20a39 \
  mipsle_softfloat=a7ad55948f0730bb08a2b1c02c3695ad4dba38d03a960e16afd41208c5d8e8be \
  mips64=c08be0dff5f57f330db6be433f9a552e690266009837e62687acaf3b579627e4 \
  mips64le=a39c0cc6e7f4d50c99522407e19f534de62fdf075e1d8d8ff08792b1adc691ba \
  loong64=256771e0a32d2a4dd5cb9d736d873c92b9a844eca9be58e791d02b9df54ec784 \
  riscv64=649da8a3b7b8a5588a18be2330acafd64601f13fbaf0b447e160bb37ec21cd08
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
