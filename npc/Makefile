# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.0
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
  amd64=b832beb13965f605035744456e8c80569e45d883bdad9083c3f4f65278059d33 \
  386=abbd85d50726e06f072f79a7bf5a5f9d3cb111ea8dde60e16c13c90b0d3ba344 \
  arm64=e86e5d84afdb216c75f2d23132d0b78d78eca42bdb5bbd0a1eb26d49febe70f2 \
  arm_v7=2392c6005f12e5e172965464f9a1da4279d535bb04e8fd35a1171a3d29e1d7ad \
  arm_v6=d573bf6e7de2082b73c9552371bf8502abc20c6927be26c8e653931f027c1d0b \
  arm_v5=11bc86d0b238a95d625d0b35f93cce5bd3f6e3b93cc1324fec7a6e7dbd0fb450 \
  mips_softfloat=4b75e62acdbf71f16529bb276128a854b350fa0374b83f0e631daf903df6afbb \
  mipsle_softfloat=0e6614d1acadd92a75d6b6a6cc01f23afcad666e0b54f022034afddcfc84a940 \
  mips64=62b5a7b7b2a9bb227dc9bb2ee38927771a87bf3c7c7f3052d33b21c636130537 \
  mips64le=d2b0cf7989501ea6aab99dcaba53f9025c59da05590ae4f5f4e11f04c6503068 \
  loong64=eab683264eec88b0dce21b73643bc65e874ec09bb4d8d2d2ac4c6b8fe1cf1fbd \
  riscv64=6f8b00fc8c7d0f3bb3082e955774b5b6adf61fd7f38902ad1b9f39a4665cfc96
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
