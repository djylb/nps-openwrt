# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.16
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
  amd64=96c65cc42f94481f44d236e4504afef0da7decce24e7a9dfaaf81c9a2da67cae \
  386=e6058a9708e203bc2debaa41bcd96757ff938f398cff51d59c03411de70555bb \
  arm64=a86f95b9aed2d6972e717e767af277944bc9c51f004d37658834ea26cd7e7b4e \
  arm_v7=5b4b8fd01adeb0ab2f525e30183967a103fb7910e8ebc7e3191f352294a3d692 \
  arm_v6=91b4ebc9da2c9b295661fb591f0f6dda1a21d8e5acff27b37e6d9ddd0535c20e \
  arm_v5=269bff39a4bae67ba7717acdeb05dcdec34c100241f72e1cf7a5f861bf74b0aa \
  mips_softfloat=dc769b6516bee439899c886a6a3f5aaff78f9d67207b5750d190626f64544e13 \
  mipsle_softfloat=68f8eeb5b62fdeef7243937655ac8eed3cc3364b1a26d65bc55eeb8a039294b6 \
  mips64=1669ce24d7530d0e5a4b585f6f1b0837c882f4407b6204c3a86347d8e725ea23 \
  mips64le=c21430677d634ebdeb09e3aba57e90e432c2ef2ac0cd3dc26de8bda63392ae6e \
  loong64=a4470e3dfb74b6fd18eedbfefd7a32394e7f4caca7095a81882d83a4623c26db \
  riscv64=a0edce2f8d7655405a3acbe4a43b3657d94cbbc11d7277e5d765c86612bd3782
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
