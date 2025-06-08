# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.18
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
  amd64=d5cbfd2c0d3ccea84f60ea163827262e729fff940f220abb0fa7152d0996eee3 \
  386=e01ea2d5152ed1e8f1888d7c472da44fa6c8cfe8c0a075cc6afbc16534d2dc4f \
  arm64=0292c667fbe6a2c0c34eff7ae5397bdfbcab878b7bab7a2bb5b37facf6552b12 \
  arm_v7=8d7c8af18fc94ef45f46a12eda0569512b6a47a6fb4054344235b188ada80ee5 \
  arm_v6=30fc43b8f5a381c17305e9e8ffc29641217880ecb42f6587a477e076bae58491 \
  arm_v5=24cd27031e4fd986c2e27fd438d0892778abe6b8249f7400f5614eb4d1e9ed3a \
  mips_softfloat=a9d6e0b95b5a80d936f9b4cf92e2c63e248b5ed997b740bc243a8ff3a843f89e \
  mipsle_softfloat=7a310665c08e1d058283eb20018910cb67ec641001f97b0ae22a22eb7e829480 \
  mips64=782bc6f42e9ac3a5512714cb9cab6dab8b4fff1539979d021b82b2f018f842ac \
  mips64le=39b7a04d0b32bc99e5ad90610e31b2c2905e622230be1d23e7d05be96d453f99 \
  loong64=f602905743d6fbbec23e38c6e47b119a4a6742c03ceb058f841c41b0f84b74e8 \
  riscv64=374468a196113c46d4c43f415100b43e865f48462426937f0e30f8b438aafbda
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
