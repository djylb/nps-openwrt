# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.3
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
  amd64=acf87261d6627e159b7287b10ac6f5a65aed2f90b2b853455c34fcf65f62686f \
  386=742fe67c778c1e38483f73ed9ff001b52050b6c74cf7b8018f2ae31a44dcb317 \
  arm64=7c2614b9013bc11b9f1cb4a7577f592925cf51985efe3e42a4e93acd6f1e23ac \
  arm_v7=ed00e36915bb1eb170d53f6ceec8ac5dcf337ca7acae341d108f306a2a2e6902 \
  arm_v6=58aa0aaf8b3cca1f1e1863798f0b50b166d821aec9744055231b05b74a46635d \
  arm_v5=0578d6036c530176e7e6f8be92511adf6ae2a35a6834b4333398515bb8c8eab9 \
  mips_softfloat=aea7f695e8b679d22e81b4d02b0fc80cd74629ebc01768659232f41cb4e7ba22 \
  mipsle_softfloat=7bb1ec2ac204599d822bce92b2e5465de47d7f2ee45d229ef121848d5d2701d0 \
  mips64=6d4aaea1b4e53972d987fd307ea1e1c395c040679cb42169d4a0baee699dac6f \
  mips64le=69515afafb567236c11e847c44c1be6e53d3aa2dfe22bba24b78646b6952f729 \
  loong64=4517177a81c927f7bef85753643d800855ea2e7d8aadf90e57813be5e339da85 \
  riscv64=d0502ef737622c17b0faf206abdbc4a6458b1d89d6efc766656630f2782d2593
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
