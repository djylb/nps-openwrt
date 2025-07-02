# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.31
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
  amd64=fbb6b66014898764ad74523e42fbb96d226d186927828ae02099ff8acc31f533 \
  386=9af5a386fd81aeb65baf0c1b4771ec6178f27e08b9ff546298e9b15de3bbfba7 \
  arm64=761a5665122b9ba5f2eb09ab6f7b9d365d95901ed7059ca1ee2fbac4fe8a09f7 \
  arm_v7=f53e214f5b1be3bec0fb3a6b75789becafe948f8570bf49d3a1da5a3c0a19026 \
  arm_v6=8708e6bc669eba99fab1c4380d79533137b79589ca5b542994279960cf138009 \
  arm_v5=c37c0113169b428aaedffef7440a51a9e9343316321fd56279f271f12448da06 \
  mips_softfloat=1a868c41c7d0aa8eb7cc4a1f8bc043fdddeb637c54a755c368ba8bf55a9d337f \
  mipsle_softfloat=3e9efb66b41e58de070a3820bd80024163b26a5f13da9459c0c84b376af70533 \
  mips64=7c74839118c741b8280834883532a2a45b61c5e0b0b13f8120679a067c7320ce \
  mips64le=f2d05f9ca247aec23e73bcd96ac7fee1619ddacb41dd31aef1510ae6602dc03c \
  loong64=cc838113c3f4c89f2c26b60b6e0fb96c1eadcd5a1b8d6dac03f789f529e2a171 \
  riscv64=f04b8854072991c3de31d7f37d62cb4af695bd6c686cd2817dce44aa8c624dd7
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
