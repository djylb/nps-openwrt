# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.26.51
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Duan <duan@d-jy.net>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

NPS_URL=https://github.com/djylb/nps

NPS_ARCH:=
ifeq ($(ARCH),x86_64)
	NPS_ARCH:=amd64
endif
ifeq ($(ARCH),i386)
	NPS_ARCH:=386
endif
ifeq ($(ARCH),aarch64)
	NPS_ARCH:=arm64
endif
ifeq ($(findstring armv8,$(BOARD)),armv8)
	NPS_ARCH:=arm64
endif
ifeq ($(ARCH),arm)
	ifeq ($(BOARD),bcm53xx)
		NPS_ARCH:=arm_v6
	else ifeq ($(BOARD),kirkwood)
		NPS_ARCH:=arm_v5
	else
		NPS_ARCH:=arm_v7
	endif
endif
ifeq ($(filter mipsel,$(ARCH)),mipsel)
	NPS_ARCH:=mipsle
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPS_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPS_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPS_ARCH:=mips
endif
ifeq ($(filter loongarch64,$(ARCH)),loongarch64)
	NPS_ARCH:=loong64
endif
ifeq ($(filter riscv64,$(ARCH)),riscv64)
	NPS_ARCH:=riscv64
endif

PKG_SOURCE:=linux_$(NPS_ARCH)_server.tar.gz
PKG_SOURCE_URL:=$(NPS_URL)/releases/download/v$(PKG_VERSION)/

# === NPS_HASH_TABLE_START ===
NPS_HASHES:= \
  amd64=061c5686aa35ade938c63a05c4b7553db38e224329774aab539c7a15f75ecdc5 \
  386=9e849b5b81a81f48ef08dda3502b1fa0b569a6744ba76b5d85ad76e5346e3646 \
  arm64=4e2b59aa439ea0490053962292f2def110a3f5c817dffb22331ca33e4adfad95 \
  arm_v7=ad84055bf6d04a5a142197c26a71a234c01b5cf30888dabd49979a0eb94ee38b \
  arm_v6=307ca86556bd8d2e29fa83dba63b8cb27d4de3b681e8c10f09c1f05afb639f55 \
  arm_v5=87ca0894055b38acd34a613d6af1010ea5936ea3bacdf431b6cce45b79399a76 \
  mips=16cda31b22f371c6635e5fa8b74fe551d715faba8df26767b5ec7baec8d42033 \
  mipsle=b7dd47fbb8ef41535f1eac5c11e5c9bb44f1325e5396692b7525171539ab67dc \
  mips64=230969f96b6d4b777a5641e1857df85070f21e797b9999edc7b3592bbf3f438c \
  mips64le=cf03f89edadf4b884f651575e9f3072e2ad0b4f9ccfb1ea3cbbd6db3375cc877 \
  loong64=1d1e4c6ca7b131041e1bafdebd6fad6ab874f94e82569a17697aea9f063167f7 \
  riscv64=9184938fdbf49a4ca62d7e83cf745a84a8cc84a2d6af25159b0829c1fe08bd37
# === NPS_HASH_TABLE_END ===

PKG_HASH:=$(strip $(foreach pair,$(NPS_HASHES), $(if $(findstring $(NPS_ARCH),$(pair)),$(word 2, $(subst =, ,$(pair))))))

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=NPS Server (precompiled for $(NPS_ARCH))
	URL:=$(NPS_URL)
endef

define Package/$(PKG_NAME)/description
NPS is a fast reverse proxy server to expose local servers through NAT/firewall.
This package uses the precompiled binary for the $(NPS_ARCH) architecture.
endef

define Build/Compile
	mkdir -p $(PKG_BUILD_DIR)
	tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/$(PKG_NAME)

	$(INSTALL_DIR) $(1)/etc/nps
	$(INSTALL_DIR) $(1)/etc/nps/conf
	$(INSTALL_DIR) $(1)/etc/nps/web

	@if [ -f $(1)/etc/nps/conf/nps.conf ]; then \
		echo "nps.conf exists, only copying to nps.conf.default"; \
		cp -f $(PKG_BUILD_DIR)/conf/nps.conf $(1)/etc/nps/conf/nps.conf.default; \
	else \
		cp $(PKG_BUILD_DIR)/conf/nps.conf $(1)/etc/nps/conf/; \
		cp -f $(PKG_BUILD_DIR)/conf/nps.conf $(1)/etc/nps/conf/nps.conf.default; \
	fi

	$(CP) -rf $(PKG_BUILD_DIR)/web/* $(1)/etc/nps/web/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
