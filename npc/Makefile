# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.2
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
  amd64=2334babdff27a0a4e18d579bf964cebe0ed0671e1f8cbe1129e5fdb2e0898fc5 \
  386=3d9f6e59e3b8e5d518269313f78b27cc09bb2e3a30700905acaf2d2d575ad6ed \
  arm64=789163602d5f21077780a710aca3ce0d6eb64d83b3f74859ce80ff29903124f3 \
  arm_v7=e602d645e600ec4d7bc8299a5aba4a2488927235c026ef09f759fa37b088b434 \
  arm_v6=12800db230ef5fcdb8304542a6ba3bf3634d24a9bab8c874ee87c8ef10cb68d1 \
  arm_v5=739c18b8dfdf7b817fb7d97d5e9621f1bf63d31b9e3085bb2824fa1ff1fcdfb5 \
  mips_softfloat=9772ae8c0c0ebd68265d9b37c6b57e7b8c42d7228c78c3f6f004ca1899cd451c \
  mipsle_softfloat=d010116355a533378acac12fcc8d42b47f14fedefc425d9c1bdedc4cf81a10ae \
  mips64=43a4d7a9e05eb6c1d468fba723fb3576ed2eadf16372680e890a499927ddeb20 \
  mips64le=cf430e05063051ffd04ead9b9724c34247317a3322bb7816d72415fcad247fc2 \
  loong64=d30e72a8df3d166b90e6e2e6ea22d4aead74af30c78fa903631cdddf555cba3c \
  riscv64=7a906d260162ac46b19f4b2e9f0f753eda8ea3f7f05616b084a846148dd2015f
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
