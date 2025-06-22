# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.24
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
  amd64=04bdd475fd7e8748ae8dcb553046d3e4e98b54df9d8a82d78b94630d89ccc980 \
  386=87fed553f7ff34a106953a7bcb3b0cca7803faa461a214863ce2358a6bfb1485 \
  arm64=2cecead1a6e56d34a00d4f99dcb36cbaefd4f10266c1073a1b6ebaa6796beb13 \
  arm_v7=3514ec8c8a43d06f2014c1e1bb51eec3602a965179b142d60abebeca6ed9f585 \
  arm_v6=00dc5ed981a2e119656e91b67639834730b5cc9cdc5501fe8642e02e86382cda \
  arm_v5=8aed6f46a332384244e926de8f4073d66402c82a31d8472dbdd0e3a3e10f0352 \
  mips_softfloat=de2c4d884f05b73207df5577b282d1d9ca599d39b77302329c6e5e1a1af69136 \
  mipsle_softfloat=5277835a09072d83bbd354540ff525de57d5f2e9662ff1fc7bb0da55599fa23d \
  mips64=7600dd0c5a5bf5ed5bc93a6f8c1e79b4a3ef8310ccb89ae03b64c2a882c24bbf \
  mips64le=9e98c6cafbed07a0f18c486866012ff7979e330a5e92e341eed6884ef19348c3 \
  loong64=6d9ccdadb855735fcf16d1c2c6e44fe9849aad4e9ea3ab46ce2db9dac779cfbe \
  riscv64=14a6f5367f7b0da87ca9df6472fa8bd6d922f019dd70d5b85391f4c85c47bf32
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
