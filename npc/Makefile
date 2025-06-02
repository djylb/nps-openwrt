# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.13
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
  amd64=be2390dcc882ab80ec497188946d8954a6f29506025ebfbe13c27175246dbd82 \
  386=5d0c2283c8a93568046e37ed650ffee2de45c6e859ca854a681541fd1c5eed2d \
  arm64=67c04a2a4ac56f35a22d692f37bd20b9f01fe40141d922ee49fb691e0cd51c4b \
  arm_v7=189592ec7164d62e433cd40469429d818e01436d60cb805cf52a7aa60d01f5d9 \
  arm_v6=9431b26b14c9b7dc74bd2785041009a11833798f7a2a1dd7871b76468fdb6e22 \
  arm_v5=109e7c5541f369805d1f37f456b7a52ee43ed1bbf703d36d7b9ac9bfe69027d4 \
  mips=3faf05628ddb604bdd5e196f38b58dbf14b54e396dcc747de670af3bb4039731 \
  mipsle=3b0bd77f24ced60bcc9a69bcc84322b3ea877cb6c5885f740c615242358a71f1 \
  mips64=c1e3955be42904ce8b23e52cf4ad8b23d7259032161bf4912182711dd673df34 \
  mips64le=1ab2e7ce1f5c4cf53c5567a08a7754b917503a3157c4543ae2fbf7104d7d0903 \
  loong64=93d4bbb5bd81e602ac174c01cf9fba2951e5ab4377ff8c210e49633171ff341a \
  riscv64=c4c031b42b69dc20b2bc97623a299b0835e3dad768b737d74390e4d87beb9fc2
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
