# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.2
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
  amd64=9f66e02d51cc15c1270fb63d59532d6f5516fa945e8a26ca6d764d7b70bdad93 \
  386=0fda0f957c7b1f1de48e51ea49dce66e30f7bffd1212a955d8b0848cf4254069 \
  arm64=eaf7c4db7b721a50f53ed75d3cbef9953b2d6344eb7929c22d3fd603b9393eab \
  arm_v7=2720c6e05a4d30cdeee740b15edcbd21d9809f92390ff320cd484ae24e948a55 \
  arm_v6=e3c12b16ed2160b599ae7c3888861cefc79a22cf986bd3298237528cbf09c8bb \
  arm_v5=8049f9f4cc52056340bb61632fa6ea8dc15e5b5d7d28a10b0365c2698f7926f6 \
  mips=3787adc57daf86a4252f055d642a43c03a4073fcb79ab3d165cbf3fe41e2c754 \
  mipsle=a43066b7397eeb34868cd3aca78697b9e5e18e6a6bd08aee50a31c28d5c08d30 \
  mips64=5d34d628280c9b2bf5f28bd3a32b96b3967b74e5229c0f0df4e58de13fe912c7 \
  mips64le=6d29c85e58921623704eda25193b453eb96dfee2af14e27cb7cd6493becdf807 \
  loong64=b3610c2401cdc298ba5e06b73b7a83871dd3b127d3b7ba4f501520e90e739654 \
  riscv64=79245576aa8d060f2222535fbc75055b6c47b31d479f330220bd0cd317ed3b02
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
