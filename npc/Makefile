# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.7
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
  amd64=9f868e9484e543aa05b7d15b1f2275d78a53de61bdcb6d233bd1014f30fd0a09 \
  386=b84670c5f2fdaa3d674027532827b8a43d52baa0050f5e854bfb0536fe5845a6 \
  arm64=b4c8850bd688788a1a30d75ce13b4e38b880bf66289cb4ace19be6a4c0d2c574 \
  arm_v7=67d9ed43eadfdc2983df0e15822803e24a90f5fbf58f69d72e7a2812ede38deb \
  arm_v6=1970fe2bec3b280b4dcff18dea4052f98ed9041e7fde6a08236b2e372a65fdd1 \
  arm_v5=3ac7e068fc8517993080d9278d8efa9e3968b000f56cd2e6cca29139c7062cc0 \
  mips=e9454ecd4a8dea8c20d47e8caa04e07d0ec542fdb372daa76179d530326cdf83 \
  mipsle=464f41fc4140c2808b33da2cd5a6de258bd07ba014557ded152de7a5e6895c5d \
  mips64=6772070849ee2ed2208022636387704f85096068797c7352668704241571d348 \
  mips64le=522e89e06af02aa448e95c9779d063d2af546bfde5eeb528239d4e0350910a69 \
  loong64=f5468629449f5731f2ae5946c3ea1deb3f9289438a8939f426099d7d4d7a3828 \
  riscv64=69fab99dbf715f998c4414e6141cbcc3559d2bea8827cc5bf3cf49ed32cefcbe
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
