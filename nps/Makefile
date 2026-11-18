# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.35.4
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
  amd64=e9d5c4c0bd9f3b47db4879c4916381b86b0da569be7e35b5573b32676aa0e261 \
  386=9374eabd57e1c0a94dcd285c3d61c23c424a24efc347fe52db6987a9d71e4308 \
  arm64=f01ca06c92c2f5fd851d24d83b19c86a97872244f8a2a6e92b2ae798f7ad25d8 \
  arm_v7=19fa4f4d7bd599df41fb62b9b3d1bd86bfe61b3bf620fa4da34fd9366a03f3c5 \
  arm_v6=bfb9507a2f1fcd717efbfb87163ec3f8558a02efea4bcdb3646fd9f2f8ebfad4 \
  arm_v5=955a3a11a958285b5a5ef898ddca138421e0b4898257955f60e1319b65d3cba8 \
  mips_softfloat=6574eea82f19d830cc30b51829ddee610ff8be5b24b217d8caab14c8b39fdae0 \
  mipsle_softfloat=ce54da44d822cfe90bccd9011855821d6ca1de4321ff3db1c2f74170729abe91 \
  mips64=0c4e81ff979a7482ac47e43503c10a49f20481054db6d12c59b3a88cefc78951 \
  mips64le=fedb24b7b9222e577d5697fef1e3bf8bcb42e334a45814cdc669906bb2f1f8b4 \
  loong64=e7c185d593b0b577528116361c42fecef490c8888a37b21e6d66514b89df6eab \
  riscv64=2382af936b75af753d5045ca62282e4ba82506c3adb64ee6a746d6d9eb988c01
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

define Package/$(PKG_NAME)/conffiles
/etc/nps/conf/nps.conf
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/$(PKG_NAME)

	$(INSTALL_DIR) $(1)/etc/nps
	$(INSTALL_DIR) $(1)/etc/nps/conf
	$(INSTALL_DIR) $(1)/etc/nps/web

	# nps.conf is a conffile: an upgrade keeps the one the user changed.
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/nps.conf $(1)/etc/nps/conf/nps.conf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/conf/nps.conf $(1)/etc/nps/conf/nps.conf.default

	$(CP) -rf $(PKG_BUILD_DIR)/web/* $(1)/etc/nps/web/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
