# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.5
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
  amd64=65cf3cec9b6961549602896c9cefaa1378ff78b1cdf5dbf03d1f3ac1de4837e2 \
  386=68c70ad5a8fcb5e416186f1a890b96c04e61210721aba2d6f67c7d40a1d3769f \
  arm64=9aba0854fd026cd62eafcba9fab5dbdc4f90d318fa8d763be1d924d2331571da \
  arm_v7=ff449f51e185be5416a25947e4ece8ca571ee42b016e453a4ea3a87e0c7c7845 \
  arm_v6=1a16aa9d50c362071c0af36c9941b4ceb76c6a004d932e5f9ebc3f518ef2832f \
  arm_v5=c473396bca8fd1e20f24c34b1fb62081ea9a17bddb14519ce7ff01e71fcf4c9d \
  mips_softfloat=91b637b1e72e033e61577c3837ac1e6a57a10a53390b05d8678606773f454e88 \
  mipsle_softfloat=4c3c77b5102ed5e97e3345cba1b319159a21b6c6bc699b1f87d0e5d039455cfb \
  mips64=e52dde65a0c8eb9f8ea92b091122ac86d109713912be6c014b9c040efce7d8b7 \
  mips64le=b35dc788db171b56298e0c2f10a31919a7e7d8098414907e4d88791152a62dcb \
  loong64=26b265805988f69753a68264d56b2ffa1588b0c02946769789dc29dc77174b97 \
  riscv64=54a5728d74bd1c0f155d25655a9d28ec434173985db628189a96af5189662df2
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
