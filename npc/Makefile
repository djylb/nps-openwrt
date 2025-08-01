# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.30.3
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
  amd64=520745aafb0162ba8b776d9ac44d29b17d4b408097afcc1ca0077e70e7fb44a3 \
  386=6ffd5afeb707f01693ff03a12b5a6b809c420f379c0018a0828bcb7de68c7dbb \
  arm64=df0f6117feda53667982e0f11e316bc2a68a202d1f69753f4999d0b492cc3bd9 \
  arm_v7=17571c712b173a9b5bd14b49e6a5fb4f97fe5009af13b8fcf0ad5b54bcd94c71 \
  arm_v6=c29018520cb0f52b0d404619d456b32058271351275692ecc100c27919a4ab34 \
  arm_v5=c53c392ce90ed06fc6167465d9adfae9a7483abf4f07ed4d490b5d1567552c51 \
  mips_softfloat=a45b30f4c8b93c5374d0b89b323eeed53b063b9422b581f2365432375363d295 \
  mipsle_softfloat=cee0655c123a4faf4fb9ab7f138859c99c71cb330e6e7421e87abf2044eecdfc \
  mips64=967327787ac3688158006f222b730df086fad2f7df883e04d644a9625990110f \
  mips64le=316a10b43af0bd2435a710a5f38ee1f1ca5c7a0eeed0a5663adc1a6a52e09213 \
  loong64=8c1f53eef7b02ec4f655fc9653912997064dba9c866aeeaaf4165569512ed00e \
  riscv64=7417e6ececc1443ee28ffcb6c8e93ecce36c552c2e6d0e1117c998ab9d4ae783
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
