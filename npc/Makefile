# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.36
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
  amd64=83e0cb7323175b4e4b823b422b0a9bf3c75fe6597f9119ae4a39abe5d1fc7c50 \
  386=ab819083df78745389cd98bd09b0ade8cd5731bfed31d94ce1d6afca30ebe8a6 \
  arm64=976fc47f55d22b8a6435b32a4c8003933fa4cb58affef700b14d1d7712fa19e8 \
  arm_v7=fc646ea66231ede33438e3c7b3debd514b37bb2e3d9d63b4e16cde492bf119a5 \
  arm_v6=71f9d5a6b0b7995f1c0f714f5faa5231b871f7980a73c5873eaca81107929cfc \
  arm_v5=9dee4e27a24f6f6dc7ef3577f3293f27ae2b856c391ea7fc2bd1fb027ecb6481 \
  mips_softfloat=6dadd1c930abd6625fbd798dc4d4e24fc1802ef9d78ed216ca080fe8065f7582 \
  mipsle_softfloat=599e649adabefc0de5206919f93aceb7a2e071e640b8fc188065d3c8023e5449 \
  mips64=dd3a2027e28a8aa0649c419821c4f166e3ae6a13d4b8dbeb5c34d95b2533d0cc \
  mips64le=4a72b72efb2fb21dc5dd6282453d940577722d49f09c5c24ed5a5a563a1ffb37 \
  loong64=b0bf8848d69f6b71b388eb2c85998eec2cef8dbd2f1d70c9fde0f65d7bc9605c \
  riscv64=ce2ad39bebd959b2be24ae7836fb8bfa0deab9e92968bc4883391479cd3a025f
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
