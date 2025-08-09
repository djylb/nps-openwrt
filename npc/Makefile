# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.0
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
  amd64=6c6d63f0482ea543260d1606d64425931ec8b02448e54c011735a633c130454f \
  386=0cbffa1bc2ae567ed75d51275f3342dc815dbb736b2a1b55d41ff3096cbb21e2 \
  arm64=7353ace9a7b29e718896c969a1bbc7e34a93e30100557874868b45a8eea452dc \
  arm_v7=44600df0174f64d5adb686ff4be9ed7ab31ae6347be9d814fac3c71b66be664b \
  arm_v6=c8c50909f1eccefc2b72719bbbce219a2f8abde43ba20938d2d3760367c17234 \
  arm_v5=80f13486469c4a9762ad7a3ad4b3a173289c61d3de5231fb6c4eede2652cbbe6 \
  mips_softfloat=b6a42f6794ee5d06ab375e00391c2f095b50d6f5c34e9efd1ff40e0d5966e4ac \
  mipsle_softfloat=7769c2d7d96d2b198952817083bcd6ec579d3264660bc81b372429194d59e690 \
  mips64=37cd54e69e719325ba4fe48b0c7021d1453d1675f3e71f960c0aeb345361d425 \
  mips64le=ae97d124f9c8e3d6664745237dc14d457f81525ddd8b3cb1aedd10b5f8a4810b \
  loong64=2830399f3b86d50e88438cdecaa05db533de22012d17487b1f02ca6dba1251c9 \
  riscv64=e1b145ae3261b56a8d78c05d1e045e373b21d20a2104d677e9a742027d96f325
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
