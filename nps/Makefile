# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=nps
PKG_VERSION:=0.35.6
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
  amd64=c2c1e27d1601605d330f69bdba7dde7e92c959899efc0347457eefb7db105d97 \
  386=a6504049cc87c1fd41317bb4a56e257a32f8908f17287d909371df220590bcb2 \
  arm64=ae6dfb126de6b2c77d925e45ae4fa7f04f2ad5b7144326cc37deba5e5d8059fd \
  arm_v7=ea8301bb80fe4e4fc78e92d4d9046732138babf41a6dc64236312714f2d6c23b \
  arm_v6=eec6bad9aa813bd749c7056ee1b3bca8175e113ff6fb3f52fcdb98130c5bb7ac \
  arm_v5=72fdd9e8af49ac03dc5687fa67285bf668766444d1cad6445182c06012bcedac \
  mips_softfloat=618e439c89cf7b05e2ff88b307837612dae98315e40e1829977a70ab1f745e77 \
  mipsle_softfloat=19096a5a0047759e54e0c00d78c15d9756ed7e38784e6019b3279d83e9a17aff \
  mips64=1462096f2c25ed7ad37ef3db1ca5d37b6f155e4bb3794b6f643dbba4b2a2dad2 \
  mips64le=94c75b4db7d8c1300e38edcd0419398e757c5fdb8e6ba761252293fae78cea63 \
  loong64=a2878bb9e58d7b0260e85a68932a233341aa6f2aaab55ed2314118b8589e0ad0 \
  riscv64=82755bff347bf3bd501867a2d0121a02e235a81edfa3ab9fd78339ad967c5e6e
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
