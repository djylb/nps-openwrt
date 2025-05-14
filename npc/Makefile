# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.27.0
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
  amd64=7c59b59d2b5fc7332bc46599a329a8ac480a70c8111ff3873f2aaaad261a1aeb \
  386=155fd3794fdf21e38043e884ad767a6061ce825131357c95241ea25f9ff7a0b3 \
  arm64=60789d2cad817881bb8034562846b7a6d84ad0aa5e125a9f0ecc2d7e385bca5e \
  arm_v7=d94af67b0e9d6a3e062c851c0a8a297a7483c82ce747ee9aeff4e432c8c3366a \
  arm_v6=e436da9f9ed1f5eb5bda7e91449ad1a6f8d72da0549fd6472e11783fcef14dee \
  arm_v5=2ba3b364674c53310694d9665a15afe9d17f464250121321f7a9932e2061e3d0 \
  mips=24535fb8ea10f7449a5a98584b3df6fd04f2ff1053cc92237d2d58feb4c8295c \
  mipsle=ccd87a16602249509ec68938e68aea46a5afd1f7799b4092ec18a4739dd4f7a5 \
  mips64=051ff1a651a1f4cefed7c96aed0c18dadc992218a55f54e13f379a90317777b8 \
  mips64le=c8f43c4de16726c96d0008a5cbfafbc8758eb1a3ac0ac2ad4a132a3be6cec6c1 \
  loong64=38916b843fdb62f7e9176a5f1a5a990674c81b33243d1b971c39feec26e6acbb \
  riscv64=f1d22f82d5e7b1c377eb45b0f4338c4f90e6d527204e5f202af512d956e96791
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
