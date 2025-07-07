# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.33
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
  amd64=ee90e599c728dec0d92aad4140772af0c261ac0472641d24afb18ea0c401435b \
  386=f5e34442fab5c71022e64d3174e2ad4efbf24b5955f85fbfd44f31f0fc2b93b1 \
  arm64=24ee15e8cd439b3f330375e083f547c86bf7285932632cea81a9eca18bb5ebd8 \
  arm_v7=309dcc21109d31799c69a701e2aa2812ad016696441dac59c76da022fb3a757c \
  arm_v6=1fce86e70a6be992aa66870b3137b8a2561ed0ca6a07f33cca5eefce7c26976c \
  arm_v5=67dbf3c5a1165ee96915992ec04a73cdf90c0a6a5a2757edff7bbdb093dfbe31 \
  mips_softfloat=a97584fbdc0993f4bb47bfd38256cef5bfd0e9cb51ae236d270c71e2b51d14f7 \
  mipsle_softfloat=c712b808b8e68f48f7e3eb944c6b54787917e2e06fbacc17f8a063685b3956a9 \
  mips64=df113835ae07c26501fb3746f794d558c6c483e758fcf265d0fafe2c1de78c64 \
  mips64le=680196facaaed665624f550f337cbb63f6bb2098bdfcdb02cff639d09c0e8a4a \
  loong64=d39ec4b6515d7f85d4084c6e508a5ec4964fb06558d11bada2f5575623dd69bb \
  riscv64=fc3881dc04611cfcdd425ddf1168a3dbb63733485ddeee4f4bdbaf491b7f0cec
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
