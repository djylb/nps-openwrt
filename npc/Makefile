# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.21
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
  amd64=f694367c06f0061b7bf277077376ebc109fe0d2e02095a70c38ecf2bc9bb5733 \
  386=0914fc937fa648a05d63cb11e0da5d1b7bf8c463b8224f45c054d2b2c886e0bc \
  arm64=2c2905c6360b92be1f69c395263523abd30d7b15fcdafc3aac7c8f4fad0d5495 \
  arm_v7=3ec690914516ebe0460ad6bad23e8717008df0450fc43ae6f4d10736ac7096e6 \
  arm_v6=07b948ec8821d23ecba0976b150dfb62c82b005a04fc29ccb57fb83845d20a82 \
  arm_v5=59280ea89852d93e068136c5fee125e953c4197367a05130a8dd1c102ab4ed21 \
  mips_softfloat=4e898c877f5c125d8c3cb0e6bb93151a7cb3c668c3972555b3718995e0240db5 \
  mipsle_softfloat=321a10bde1a3a6dc884a370f8df4f47eed1845eb415613e403398f6c60a06b27 \
  mips64=e742a79ac8c131d705bae32b3809fd9d0d9974b187b7192c519b56c26162c329 \
  mips64le=eaa831ab580918f7dcab87d62249794c82c9918515b12ceb3ab08739405ae83e \
  loong64=cc0099363e405a453ec49d66e44be161362c903456e705ef3e888ed454474e23 \
  riscv64=025d4c8087d7f72b9299364bd2dcb95b4c42f614f24804ad66daec3943cc8b02
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
