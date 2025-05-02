# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.26.54
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
  amd64=fb6c5841812e4285b45d01b02088ee8fe0b5dd239d9f258dc5ed50bbf907d654 \
  386=ee649936f40aa2b2a996f4dd7efd6972fda291637171afcbf27a04566f140088 \
  arm64=6bde249cb5f0fbaf1c3365ce9b47b3a7fa8f8c773d353ce9c7340e984cdb1fbf \
  arm_v7=72ae9a375c95a1c04d6059b02e03db0066310d37b3eb7c7af9e540041294cef4 \
  arm_v6=caa4e40862c5f1516e48f9f42d0bd138fe6058b948abbea98e21a9f4a24e1c95 \
  arm_v5=8987b667492fe9757b96135cedd8d00815897e3cf17ad1081bdd391789a2c39c \
  mips=33e1309e6742c6340fb38e97030a019c93c628e216017a58974e3fda3bb0975b \
  mipsle=51b0244c7e78fb9893ee292e7811e8ae3f589480d8f60107c6b8f7c51a5b3d8c \
  mips64=b67ff1cae46293079fc6985b6286266014908574194daa419aeab2b7c85d45b0 \
  mips64le=2f229f81dfe9b2044362b278e1ec992c26fd73baca0efcad01e43d03ada4f1da \
  loong64=190b1b23e6c1c5ddb1f34c031b4f563287a2d27d8ac9872fa011acb6df4d691c \
  riscv64=a644abe2e5b5a94f8a6505cc3ad0400c518c5995bfde3c7d2eb506b6cb93d83b
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
