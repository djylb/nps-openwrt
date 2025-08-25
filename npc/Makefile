# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.9
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
  amd64=407602c38a061d4c760ff86d5638f6a4cf06d00a34df174ef7fd847742af5a26 \
  386=0e1d38f5a4baf900f0170abc4fd8548a8261dfe6435877fd5cd9250207f43490 \
  arm64=5372153875b1643a496f3508a82d1ce6f8a25af321e016f0f03914cfc9826ef7 \
  arm_v7=207d7d80421667cbe1679b5433be9701bcd9224da22d92e301c7c89c7281dbe5 \
  arm_v6=f0689bad1d594b5d618be6ecf33bf890cfc647aceef6165c62b67a6cdeccef72 \
  arm_v5=0decc3b58b12ab91c7da3c558cd0882ab046657900a6d8ebb0b001f793eb8166 \
  mips_softfloat=05524d8b39d812fbbf5ee4475c34dfc2f23baf88ff81f5040b7344c06cbec196 \
  mipsle_softfloat=c552ea28c4a803a3b753c53d63e1479ca5147b1f1f96f15e20c86ad4a2749338 \
  mips64=0ea43a3e63103797e7d24bf7c1abc500e0d91ae34e03e7b51096655f6a1a59c0 \
  mips64le=f46d7ed3e9f362661d1acad03e0b56658efba0f2797a89773ae00fca3053cfc1 \
  loong64=96a31abe7975fef8a2208ea07257b5e25cd6e669d8b62fe00fce53c97572d5ea \
  riscv64=dd2c4a99d218b6cf802971b4356259377eeee7297296a82aec15e30ac181781c
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
