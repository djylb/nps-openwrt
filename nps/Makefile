# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.30.4
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
  amd64=d19e8278aeaf8f67cb80df9d0ac2bf0c7f483defef96c22bf6d7984100ededf2 \
  386=d97f92688e9b86f05d8618f50553e4ed1b9e1756dca6ce7a5651eebb08e6969a \
  arm64=d9ff1cf0981dc2019f61d6c985cfb9e002a7efbb49eb669c93d4ac79a5649e12 \
  arm_v7=21a153b212ca97beaf2cb8171537aec1ebf07931970b9d7342309060d62efc29 \
  arm_v6=1204b5b5bfefcd392be5565ba885f1a01845c54756fa855079a4d3a6396a0584 \
  arm_v5=cfe3b8469bf3d970ae6e75b8886c12867cd254dc262a7eb9fbab2b43ddf6796d \
  mips_softfloat=46bf96fbea8cbba57a13e910a0392fbeba301e66a33877ce5df71f4a2c2b639d \
  mipsle_softfloat=dde1169cd8083526657b6d6be7ed3f5eee776f70b97bc167ebf7bb3842ec65d9 \
  mips64=743ba7bc45ff3c88f9885f6a3ef6ce5e1483d33854f838dcb621ecaedeceb37e \
  mips64le=b57432ec8b6aac6893e932dd202e18881c214895c7f259ec4f582f7928ffea86 \
  loong64=84b532c59ab763b99da5d6c1bc68205a4be2d60e7998202510ef9f4c0976e155 \
  riscv64=eff41c0cdc73f877f66370b97a22d63593c602079f9ba65d076a4096652f9ac1
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
