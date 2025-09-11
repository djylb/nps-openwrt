# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.5
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
  amd64=6912f7e2606601da3a7becb66ddab21eb82914f3b4a095e3873111ad0c4b6c31 \
  386=46d5e98dc1c9b8f52bb677d672f5ef162625f4b58cf6ae8be424216e433b262c \
  arm64=efbe7cb75c16c493aa86ae8b6ebaa47282e1159693f79f1bc4faff2f09f198eb \
  arm_v7=dc08b1c6e9b2ff1551299c1dfaeff937e47604f94d4eeff33d5401be8bcfc1c4 \
  arm_v6=90f87c142bda157a3acbc54e45feb1d6a6425839f347cf9b9ed976c4683b2f73 \
  arm_v5=fe6fd0228d13649651375e172000c570a1c3ec08fbdfc62c9ef4d441e12e86f5 \
  mips_softfloat=5db3de4dd6a8dec39ced9f9f787e439aa0cbf0b695b22cfa8d0fae14d02314b4 \
  mipsle_softfloat=9edcc3ddd9b8a690a96776f8df6bd9d2d7d261475aebb090cefd6b2c3a6d20bc \
  mips64=2dfb6a4f1300a4263d38c35590ee9c0844f618588262d0b200f3dd57aa4024c3 \
  mips64le=583bf597216366a63eeb1aa734a01089db9ad80eb38d7e5f42cefaeb917dce82 \
  loong64=63c2c21308893a5af5b319de789e646b365e9f3386afe1beb21cae41765eaaa4 \
  riscv64=95eafa7405fd6966ecd2a82b598d217e6f9b859abd867bdd2de06a0338afec50
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
