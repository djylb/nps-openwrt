# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.35.5
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
  amd64=7e1f4e6fa363eeef48d749dfb3ae391359af545ecd909482d2034e60d658e071 \
  386=c2de2a7e9db06a3a2ff4ae92074b9c3062dcfb7455d696d798020fdb540dd8a2 \
  arm64=5841836d25eb0f65b495a01113bc352dcf2e195099d58858ff86462d24b5fef5 \
  arm_v7=902d545374904b0c5e2d5cc90802746244ab228dc28baf647925ee9b08cff208 \
  arm_v6=8f719eb8eef0cd414cf76092eb9b98a22d6d184d48f250ca031e97aed37ea8ec \
  arm_v5=803dbc3252b575a1e8824ec40a1c884f3ca6b76832226306d3d21bc25737e16e \
  mips_softfloat=71b7b9c1150daa2e16b044a9f2f8562f39fde0fd72f443cfc6eab93a3e936cc5 \
  mipsle_softfloat=0b2950873b0c175dc143b6f6bcaa0fd3b7a4e1132f269cc46451b651163f3732 \
  mips64=bb749a0b8d0963440c42ef20f5698c1850a5259e12c8830e0a0630e231a3276a \
  mips64le=39c04c5535c09b27a5dc46d8b72457dc218607a4f4a1cb5429823d03791221ec \
  loong64=430d53a33d71c3e7f8474e0c1b04042776726dfef5650b7689fa94d0211555f4 \
  riscv64=d924834ea5cac27567321d69889f53129316f39c61f4964f2bf387d0d530dee3
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
