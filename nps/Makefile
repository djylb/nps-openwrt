# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.34.8
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
	NPS_ARCH:=mipsle_softfloat
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPS_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPS_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPS_ARCH:=mips_softfloat
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
  amd64=149755610cfe11110e743a41bd2787eb826e37cdefc71a1a0e0cfebf8ddb28b0 \
  386=e75ad413518c0ead7e14702f75a8e0d39e69fe0d7184902c0a34b9554ba7b416 \
  arm64=bd954fb9e5ee4d2582b39664500eaa38737d7a34b31a56d46175a420d80f7614 \
  arm_v7=01ab409f45a12171267c36e77455849c294816a402b04be14a48401ad221f856 \
  arm_v6=c22ae6732f84dd1783af017d56e7d5dbd1c21ad41e077c1b73557d89fe0d5863 \
  arm_v5=a32bb881ef8d87f3145fafd718cec486389216ddbc3bf0be7116e6d2851d8d01 \
  mips_softfloat=1640647cc361732ff5c30038f4844050a1c204f605b8a146c833308482b00226 \
  mipsle_softfloat=d9b5663e8aab52c73f6c07b6cd511f16668364937ef1f62069d18f688f2b915f \
  mips64=3ee372f50cd4d38a6eb3a52e96bc90688f52e68315e840ffb803ca2276b5dea8 \
  mips64le=7024acec98f95a2ef1e7721f1162b2436e330ab1cd949a104e35d3b8620029cb \
  loong64=8983813d68b0787b3f97f5b2ad61e81e8bc226ce10c2224b9522bf196f636637 \
  riscv64=201cec275d867d7189a4805629cab408acd27de37e6bba6ff324f1802273b1de
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
