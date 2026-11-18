# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.35.3
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
  amd64=8c4122dab5be9887336aa6b74d06fd0093d12f638225df8448b35d46a616d868 \
  386=653dd831a84df4087ef698cb288b037fd1c471e8dc6b8ea799f2e76fc0629f3b \
  arm64=e6577403c90926f280224969863fc952c50d01608168acbb40332f0d5c3a4e51 \
  arm_v7=9ab0c8237d1827ee19e78bfe6670ceb0d4314db4edaa3d8628ec20a7686aef58 \
  arm_v6=c6d723c3d13e29a41fd8fea9f61bddc4a9612886785e3724e1a4fdf6e7f7f132 \
  arm_v5=3c43185e8ff3f3efcc8f03c1250337d44dcd03910a014037c1de913e86379ebc \
  mips_softfloat=5c1c273396a348dc52bb6ab9c90f92936b10e26014a7319d013f8cb240fd1011 \
  mipsle_softfloat=793d4eb407cb38c77b7db884be9d98e06eff1dd019bc615db7b4136a3e66bf66 \
  mips64=fbbf6021515505edd040aa56b28dbef9a17a373104c720a7d3dadae0a1c2ae14 \
  mips64le=2d62e7ade08a656c24293331b6a5638f140643c3573e673d7d63e2c0736a45b3 \
  loong64=08a0b3c4769a4d95e3bf02a757dd0419e87b8850b10d521982de893b20325329 \
  riscv64=e6bc644cbfc4fa94171d68acc9dd04444ac8511a75743199dcf4dd2d43e56eb7
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
