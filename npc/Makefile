# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.37
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
	NPC_ARCH:=mipsle_softfloat
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips_softfloat
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
  amd64=3d297212507448ee3bf513876739998c7a5f3f69df357a4c8f5b053bc270c382 \
  386=f7970774f6e91ec0aa4fdc65955d6865849b5a55848339cf988f892b86af56d7 \
  arm64=fe4189b29ec110ffe8ff40abbd6ae32726691e034cfada952b89de3bec57d966 \
  arm_v7=d4301d9472a1eae68e55fd58374f416dee0974fa30db90065be7bfe599d5d148 \
  arm_v6=5f1a80d1f1b9d34813d71dd58910e98e530c3ca416cb9adda4c1ae9bd5a91793 \
  arm_v5=f1a6b2fd41e52d4a9c2255b97a658cf1fa461f17ba02ac9af55a84b5fd72949e \
  mips_softfloat=969cf68d263468a4cf492f0d299e22b9bd76e04478e4bed422cf1e3667b65c14 \
  mipsle_softfloat=7b5d0b9863741f63c8c55d7ad8b9174f59936b65f8b634a90551af455c022f61 \
  mips64=03ace267a6deaf38424c750a43ddbf5cc0dc421accf64943ae4f8f08c7331a9e \
  mips64le=5b786efa6a81025e1e52afe9f7d7b4cb340240f95ef2ea4aa1f2a3d88308c7fa \
  loong64=717bf623db3a49a7ac7cc346de4352f0b1d51eafedbcb237c1e30ff2985486d6 \
  riscv64=ebc66ab4291a256d9f275af60abd6a174227b95b0147273473c4a11cd278b239
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
