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
  amd64=1eaea5ed80ab006a3e3411547487dfac384e02fb700c8c34380945b619744e07 \
  386=ebc55fcafcc07c1e5ea711f970eda2b90f3a4f1c3f15707d0fc20e7858b026d1 \
  arm64=64f2c71d0935a9f7778f8a6eb86337e7e37f50b8856bbe35ab36fd6453f28e83 \
  arm_v7=013bffd0c0889f395e5f6fe620c76026c9cbf1bb5fc553978ec2dc96cb4989bd \
  arm_v6=bd694f10c10369fa4a92892ae7783763a903a94cc4c7a383108aabba221bbb39 \
  arm_v5=7f7c610a7ef8e75b8cdcbe8b6945d1fd4cbb4fc5fd2cfad194ae57c9f21077de \
  mips=ab6d6cd7e7fd5c2dd6fe297eb1999c30d6a7008c10ad8a375369c8bb11e796e3 \
  mipsle=75e8a5b70c899db90a599c3fed5b74f90be59b236000a0789502a7b9a73f464c \
  mips64=c643cffd2d3f1cc0abe29f3a14c719ae0799cc55930efa887fe6888e872ad7b3 \
  mips64le=716cfc97c4ab655df9853975199176c7b7561b3d70b3138028a5c3548f5032fe \
  loong64=465d71314c730142242d4973a1878a6cf4002f99151384f9bc478864c138520f \
  riscv64=04c89b12938341b4269d41530012f712adbdfdb64ce69ab3b7c4d497811717db
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
