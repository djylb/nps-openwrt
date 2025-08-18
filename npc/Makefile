# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.6
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
  amd64=149393d1be3dcbe3a5c1251756740a7101a283f5b0cb779e3e35be6be73a5956 \
  386=86d1a2e12a3f80d317cb357f28704c729a83de48e8fc08bacc4396fbad11ab40 \
  arm64=5de37d513d0a1f442eb1cbe293088c2c53916b1a734b0a6be1e2ef579b738bee \
  arm_v7=76d7c670da28ae41f6f86c880b43eb20be54e9c0a9d817a1969282f1f15ad3d2 \
  arm_v6=f34c791dbf09fa080f002c4327c0639a0f166d27f04bf3555af4e4e37ec06ed2 \
  arm_v5=979336ae8b28213437b16fe69388bf983863d71b929565edb94ecdf2d5e1ce33 \
  mips_softfloat=185ada1efeee7c65b53e9305040000f9b4d81f4c3b2d4e9f432dd8f096603a82 \
  mipsle_softfloat=03c88a05e4b87792511990eb972b0a3f0effcd302894d050e1587ba130b42639 \
  mips64=4745e1ecf58169afa973cceb95ba1661c4f66bb8ab63c1ca8070602f27c32fc6 \
  mips64le=6d856b0f5cff21a5a5db022389883f0ad1269b660cdfbd03cfd9898e92f8973c \
  loong64=511bcd94e5277fae016412fa742b583bc3ea76c42ddc5ce3fe33f2140b8d107b \
  riscv64=ac732f257e79994cff03f0669f300e74d7bde9519663acef9da860d220b5cbd0
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
