# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.10
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
  amd64=6fb4d31a7eb935a48ac44af3126585afdfe943252be31abb43ad89edc9f915ea \
  386=efc8a00aeac6da705157a9db9845253a137fedf92819a5ce430343c58b85490c \
  arm64=00776cd32ced50782a0f7a865188ec7bd3a74cc0c696231e13bb430b1b160e89 \
  arm_v7=790f71252ea5159c8bf12570eb008547c1cc93575fa3af0e001f9ef577a82b07 \
  arm_v6=d9cca30059a7c8c54daef7549909f63441ede9f9923f69dae19c9b1331cfcb1e \
  arm_v5=14905e919e456950bc44ef4deec8fe85e6fcb7acb493f09524c15ab7f0966b72 \
  mips_softfloat=890ba11616cecd816151752f255ad50878b1a802a8fde60db9179abad3af913d \
  mipsle_softfloat=ffed85341a28cd7b65d3369ce9ce3ba7af9980639525e2e2aefd4203f161cdeb \
  mips64=6e1a22aba059d1e1001d633d9f2bb667b5a44a75d19c0686cff7bb57633bbdce \
  mips64le=bf166630213be3fefaf72f77169e72de06fc6713c5b5c3f5483327cc1b26506f \
  loong64=0e7895be83e8cca813eeadd804b337e98f03de99a0b99fdc30a08e9b0a6afba4 \
  riscv64=20628229bd41803eaa8fbbc7535fbfd20cbd4666ee3d4d9ad7360285845abe30
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
