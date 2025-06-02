# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.13
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
	NPC_ARCH:=mipsle
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips
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
  amd64=424fe4515c3be1e7d76bc3b8c9a120677ea90fbc8716da54d8a99b2a235b9f38 \
  386=7acb9caae422b577cf01285a1dd571413615af17974c305dfc5ceb6742e458ab \
  arm64=d8c9b71c254f3d8e5f2502e84a8c90b825bcedfcfd23e21a9c355316946ab7d5 \
  arm_v7=f97cc474e34a688d3d8047ee0ca4fd7771acb4a45d7efecdfc04be23b43612d9 \
  arm_v6=dec26dab73ef2de0219e01c2bd364558dae9142166b52b459386028f666f58bc \
  arm_v5=dacde7109bb7d9da44ced7588de47c7ec8f39fa6c87cba506bbb3946330b0635 \
  mips=34c2a36de9beb6e78282c22c69f438ac8fa936ac7d9f8bfe5c74f657daa243af \
  mipsle=2b7a0e7ede81966dd61c84c443c526c904023b95aa9e13e06c8d8231d596074e \
  mips64=61fbac1d5cea0e5c9e08721a5102e23e214a08d5b6feb3206ca4776ed612efe8 \
  mips64le=4a79070796d27d60f5c7321eb8f4b2924d8f49aed32fd76bfe3ce21713043724 \
  loong64=e6e23084cddb802b13e70f2fd2559f7530040d36392d625523059785d1e023a9 \
  riscv64=453b087f51cf657241c1609d1db9e4e1f92e991745e823ec06149122ee92a7b9
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
