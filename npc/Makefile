# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.54
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
  amd64=e9d9ca5e6797297b7e0afec4bd49db340fa46d3968bec1ec99eb636866a1e1c4 \
  386=bf7c4ff134b17f78116a2704efb113fb22924ec9f3a48442264a644648102aeb \
  arm64=322e8366448833b3bde5c1f02f71daee19b0bc90e29326eb438ad79d07ec246a \
  arm_v7=4df67bf5f89cb7ad6dc31ab1adbbaf8324fd5ecd6b38b916603dad40dfb35f95 \
  arm_v6=8dcf50fc71bd08c013f8ee0b0762a75c36ac90234596996cdf718357abb6e7b8 \
  arm_v5=de84275d4a335329053078d4d5227ab97c336508b99f732b6976bc973590b055 \
  mips=e5af6092bc72a0b12fe69f782971c3f31b9eae9360a6c58f36265bf6c963001e \
  mipsle=2f95b78728a3edfd976d2df7ee44377ff5309558bbcd5845a465a81367d81638 \
  mips64=c9a2fbde531bb25286edcc4335255c0c59fa603f13cc04850277e9ed4c983d93 \
  mips64le=2406cb0f9bcbe2a825f84820d057630d98effac0c9a2a42fea2609d841bfa1af \
  loong64=17602e1fd0bc8be90f563111ab98857e9b4e6772f0184f33dd664331cbb83631 \
  riscv64=e14cb689ed5dff2d650d95d7e59dbbf2784cb050bf3c75bcd7817f8d3913d74d
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
