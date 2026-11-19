# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.35.5
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
  amd64=70fcb19f7e23d5b625be580b0d1f0f63b9422f2d037947d8b8f1ca74bfd25c55 \
  386=c6c64f860e1f23230bf9895adb5b8d20682ddac25cf74f477402ae16c13ff7b5 \
  arm64=1bc01b703318a3249df7b05a3f7779e0f218fccc254964092eb22a138b0417c5 \
  arm_v7=0bc1f04dc46abe7d8017b0567a5e5b7349bfb33637efdc18de54d7386524875b \
  arm_v6=9e4c0bafa64507f0d91a83c8943f9f3b99063e23b353739892bba901f23b695a \
  arm_v5=039aa9a678b04df97147b337a987ef80751b694238ffd9beb28cc2d351620037 \
  mips_softfloat=d7cdc98170ce154d650cfa76267af2eab09655ba19af420dc9895074ffe7c9f8 \
  mipsle_softfloat=aa1909ffee390ae783ac28c226b288668d6057b9db4afa0aa5326a1c3e311831 \
  mips64=bde5fcc1f9d19b12d615a8fb07aa2964dfe5e0bfcc02f64ba1cbaf13b26859b3 \
  mips64le=16eb9eee1443147a80a4566e85a5cf7c1518f0166c2f45541287c399d1578d83 \
  loong64=002a61b221f3f191060b9bcada59a01eaeb68c13298ef328f7c0593f24ff77fb \
  riscv64=a4a26ad044003bdfa330b027ea726c662170e8c634325726ac102807e088a1a7
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
