# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.1
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
  amd64=2bbb24394a0bb0a7fa8190f09f8f3290ed33df602a0ef28d10dbe42e1648bb4e \
  386=9b1a6b5efee3d21c240278aaf51c8e6c7ff966a79de3b4b11b7e6accb1aea257 \
  arm64=f67186a6ecfc4977e4e5411e5ccb89deb36daa1cf8a0d114e128156247c04d67 \
  arm_v7=cc3e16396045ed2410dc9747a33800b2702da3f01a8bbdb8e3f7b99e535dd7b9 \
  arm_v6=02931e439cfdbd642a2d3215ff96a05bf85220d74c20e67ea3a508b334e39c19 \
  arm_v5=929136dc5d405a0d7158eda21f6a7e5856d469a7da0a1f68dd9e427c7b5c9818 \
  mips_softfloat=73d2171518530585b799e8104d2e7cca9ca9b28290af1407d7be98e84b2d800f \
  mipsle_softfloat=b7c690023d8900c96610d96922e3363ea6635b8a8a643b161ffa027688b1d8d7 \
  mips64=e7b69c8367ed99ea3425a83410d3644d834b5bf4b74b9f341365248c7148a2bb \
  mips64le=96e16800dc4b4e4ad465654d5aa1da870206a9a6a7a202628428e7b0a027136c \
  loong64=01463f1236b99fb29fba32a4e47b5d3befc34a343635aad88c38991b78c005e4 \
  riscv64=ee94fbb982f25255bb7439e8e68256e43287354b60bbfeca9b974826f9d2b6cd
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
