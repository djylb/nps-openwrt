# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.29.12
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
  amd64=2b0e4e5fae9d427d191b553b08700f6a7f3083d8dc99270c760a254c931c5c9e \
  386=17451ff0c253b86ac467ada8b5ab3de0fad18184a100fa58736cbbbf7618c704 \
  arm64=dc8c3a99bbc140ee87abccc067a2a089908ae49d90d95c8a4f00f0b676a1360c \
  arm_v7=ddda1eb7f875f238b3f9b88a20048b256aa2ec402e2531c65f9e3bc57b952b54 \
  arm_v6=7ae71487072eb2e2c9db209fc961a72c765281b5b2cee28430dc3a2420bd2b5a \
  arm_v5=1ce55bc9991a0ca3e2554d52f902dbd527d5fb77ab0561ab53a3fa13b09ffd9e \
  mips=aac707c65c7b0787f02cd483ddb6aa848f44ba696e63723ed2902deabacd21f0 \
  mipsle=0785b90259593f3b0007dbfd47a71a8ed1f07a0ce2aae42963f225f8e2b3954d \
  mips64=5d170f67dea602a47e7e2b526ab70e73d9c88a5c36d3f2729a617fa7f1a672aa \
  mips64le=5aec350d70eced9e9c3c55298ed27e641f0eeea75359970a79c7686908fa2f1e \
  loong64=c06e7a8bc223589132e0b9668f8e7dfba4aac11ffd4dd48df7736f0dd3b54615 \
  riscv64=3a3646ae8a3ffb1d0193d5aaba572d8240db999cb48d8812545a7677c447482b
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
