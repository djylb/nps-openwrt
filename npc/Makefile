# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.23
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
  amd64=c0fdd66bd9d728ece0a9f4417495a22108e7a1994ef4b7597ae3d884a6731994 \
  386=134a43f15d0247c8828cb8cd4870780dea9abb9b7a8657d2cbede16f9695969e \
  arm64=35cc7cb6779d335a4a7e2b57e0bd3aaf3260abfce30ce426ee20524188c8dc53 \
  arm_v7=b17486802b271ca7c7a1351309166a97650a6c9d4dbf89931cb836e5be412990 \
  arm_v6=0cd8641b33fd42b4acdac78dfb1bceb3ac1ace4ab95bd094a9a58445b085de71 \
  arm_v5=8849976ebd06ae276632c3df18c8bfa4d08cae896e72bbae8a1f98d49cb96b31 \
  mips_softfloat=02baa3dbf6750e0eb4804d5e6048bca756aec3ee410020e7dc2106e71b9ef084 \
  mipsle_softfloat=347510f83368a5214ad59902c5c4f263c15bea3cb9be0c7b44a06219ea4cda2c \
  mips64=bd1c55e72943c744ac1e4443baf33bc9499408679bdc3fafa005621c759beda0 \
  mips64le=0058c7988ee8687de5ee15dc0c2f229f1ef33623e84a7a894ada86a011af59c1 \
  loong64=92d53613dddefd40348a1a4bdf7f5fc23291eeeaae7476e3902bb8a49bc34029 \
  riscv64=3be13f70f503d829d6f8602f6f9aadc2731f1dda5207c1d5b8c78551ce262368
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
