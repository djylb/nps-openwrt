# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.4
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
  amd64=947e8d93fcbb751748ff64021ccc68c592c6ab1f2191e119c213622d007fcb70 \
  386=d3e99f9661f25e1e329c0f618887d9717d77dbad97ea7bb5a6712a5d371d946d \
  arm64=6238a87af7a17e048195d88f95ab4645e4ce51e69ed4b2c6b46f5b5e3c6da48c \
  arm_v7=a05b16035bf1431ebbf64e5573441d4716c7e7e6551839694684a6c8fa5a4f82 \
  arm_v6=5447b1b48e631e7db388c733b044c3fe620048801b5d9241127873bd7111f7ca \
  arm_v5=6fe1c4424330e3830d73b876ddefbd1d0023d9148262c0347d92425f01ac8653 \
  mips_softfloat=6cafdbf81ee1805930165f58aa67e3e47234fb4c8499edbdf5bc0b7050c8b5f4 \
  mipsle_softfloat=90d78eb41f785b7ed15fe464c92748c846a513e07549dd6efc3ed3dc02c80bc1 \
  mips64=86bbf8b6612e4666285485b00122c2520f62b8e94c1bd3e70eb0be0c3fbb602e \
  mips64le=336248f105ebb55a7bb5a7d31b44fa0c203eb9097a26e7d35665553b37874042 \
  loong64=f67ef838c3c53624b8490f36b87c22395d928ac04b4d329c7d447a54fa3270d9 \
  riscv64=de4f08b3057ef947ed693f3d8ef599c22200e8fb1a89be9838f224c68ae92266
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
