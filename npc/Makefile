# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.35.2
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
  amd64=ea4ed903ef2f7019dc7f737c5837d1c45f9da207d4e61b632e621cfdfe0b702e \
  386=555a4433af3ad660b78fa435a45283c432554176daf61e410644b8aa1508a330 \
  arm64=66ca39843df62b8da4e0a015fc97dbef5e7ed68ec53cc2c8f3476c8deffa51f4 \
  arm_v7=8b2cbc327de744cf328701d6503a10ce33f6a68fe94efd7611182f01d8c4ec23 \
  arm_v6=ca063ac7f58168b050796e4d5a951e803271cb97279c25a5ce4605b8c6d4ef98 \
  arm_v5=7a94b033eff9b6bb100575a45a8825a13dd04cae1a96cf30c942d2c0e8436268 \
  mips_softfloat=e0e1218eaa31b75124ce400be2db3965a73ba5ec0f2f7f5fb4d1355ef207833d \
  mipsle_softfloat=cd84405e4e5260f28eff8fa0e35cf344a773c2ab2f54d3d1b14ac103a118e413 \
  mips64=85869ed334b624570ff4f702c690db1ee651271a207854fd1c19e87600873d1f \
  mips64le=8ed8ff8020550c8bdb9bc101716f53691b422f4a5318f97ec5efdf5bada3fccc \
  loong64=e98f6705187440e96fb6711bcfec2f1dc3c47f8f1e4b1902963b5603eecbaff6 \
  riscv64=daef08a752ea98ae493e3da44df982ab71e2f495be429a7c1ca648e5a8da9480
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
