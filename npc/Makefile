# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.2
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
	NPC_ARCH:=mipsle
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips
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
  amd64=468440bbd9141501a786f3347c4f9f882ac9b3512fb7220df82821e4041899d1 \
  386=a9c42b1e28460d595ff55dc54344ef1acda410d1101da84d4f37ea3c91d377cc \
  arm64=ac1a52616750523375672552cb8e74847ff65ef65113b2d1fc6e9ccd62017cd8 \
  arm_v7=9f6b4ede2adeacf0b5501821047bd16af54e770a185bc06481c527c80434e8ae \
  arm_v6=4081298c7c63617c89dede8a5f35b59e2c1941c3164e4a06b9b06cadd4552e0b \
  arm_v5=268b93ae0e2b76acfe9b3d5baf39444541f23c4ee252211ad8aface91c44bee8 \
  mips=07dbc60ccc143adb33a1d7f995251478b1506e621d83ecf5ca55cce0d3471d0c \
  mipsle=995afc5cb13e83c27f83a04d487902f4500b67e3e84aac11e622203d008e869f \
  mips64=67d0d9967952e261004863b45c392d3c19a3584b78d77911a6706f53573a5c66 \
  mips64le=9b09a60c0e1f5268ce5c56dfdc96fe18da2f62219d781a68cc48d5c2a9f3114f \
  loong64=757f7a336654bfb202fc831ff9f369f627fb0bfb59943a2bd414d207c4ae2a00 \
  riscv64=66c9d498ef0599bdf0e145b0fe0612a17e2c4a7b15b14fc466261acfc90040c7
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
