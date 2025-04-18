# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.49
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
  amd64=1f25aa565b38564e2a5ef53ed59e1908a698d613391c328cbfdb61509ff573ab \
  386=fc3d354ca44eea6ab806e4756329ed04710ba9e881a838c24c5d76070887a8eb \
  arm64=30918263a5e324e2ca24764a97e21dc5049fb798000586cb1f1c79bf3fe61a3f \
  arm_v7=4c6000962a46b17c65ebbed4262a7608147e416fd6289c46426918d03f72bbe6 \
  arm_v6=7396eff0927004a9983a58195c8ee593daab1b46562bbfe3dc172e5270674e4c \
  arm_v5=d7c73ac15a1cf305e96bc1530b1c243ac335e5f7d485ca99a11c8d569cecacd0 \
  mips=3aa5d2211836803bafd7efd2a41a22a6ddef7d39f8dd09d359b27a406f8d4faa \
  mipsle=f678db1ad6369410b5f716fd81729355d6a5bf05469d31f1f4cfb72698866f06 \
  mips64=e03fcfba2283094ca9e6064c945656359988dced4ca8e5de450337e5d6970f1b \
  mips64le=28e6caef900b084da418dd8fd9c7f16b831a2b3fd123b6482bb9e7b02abf16f5 \
  loong64=0fcbf64c49681797f99d0ae26a8e47be1a669fba8e031e3de38caf26601fd072 \
  riscv64=0334bd7523ee9daabfc2ceb0ae261ef4675b25c08d893dde0c1f0a3fb217f161
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
