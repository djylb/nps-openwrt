# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.35.3
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
  amd64=2684f66435adca906cbd26fe5a11e4c429224366aea567d3f520c0bd22b694fa \
  386=b3f7175b550884a7a98b36f205378d3f8c7027bb8ccca59f2801960c18f64d7d \
  arm64=2a4f161eb8c768d597361d8a75a355ab67e0ce541bbb958bd21704df4176ceeb \
  arm_v7=bc80790d9a136657afc5a530404702b217453bb0b854d55275fc66fbfb46f7fc \
  arm_v6=125528fb077d64d2973e17a6b2a374b42c4052fefbfa17856643d27eccfa003d \
  arm_v5=98a6273252f05e933ce3e8df62dca756140b9aa83ed8f35a1ad1cd2417166cd6 \
  mips_softfloat=67206c11cda656528167392e2a203d166640470289b04d490c667e196c2ea7c5 \
  mipsle_softfloat=687daa5c2a84bc87f05350f4f79a39cf92da4bde13aaec8bddb3e49e3ddef7b3 \
  mips64=1845b13ae442669afd624308a2b68c4e1893ebefd8507c46e1942e9b6f172fd8 \
  mips64le=c051daa2c670aa038504332fbe6ef620b18156e9e50553ad0b7e8686db77eb1c \
  loong64=b7aa5efc6df28b01e993d428c8be3ee628b0fdca03e5b755faaf654ab21f0f64 \
  riscv64=2e3f87297483559de4bd09914fcadcb2c9bb99c196baafb5a5d70752c65829af
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
