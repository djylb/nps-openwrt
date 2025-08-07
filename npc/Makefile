# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.31.0
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
  amd64=af8e050f32b72e7e4b005170c65b9e3543b97c0d72882d81bc45a1754229f88d \
  386=e7239aa30fd1868a1b120f8b9bbed13b60d1175fa9ff6039b7d90845085619d7 \
  arm64=323e8d64969897741b1de388653332afe14fbb03e864a0217a4f3f24c6defaca \
  arm_v7=2ad5213b5ecab0f95196f8203dea71e6ea5874be376b0120168cff03d57614a0 \
  arm_v6=20e3eac9ee091d102363eebf07b541ea5571038155f910a7fc23c91084311529 \
  arm_v5=1a1d8db92b722cfab07b4bcf99f65c23b7ec547743bc0c108165cca309ba6122 \
  mips_softfloat=0fc2f961b379907d4b3ef3d120b897e3d75e01ff69ed39f6fea35044c0009117 \
  mipsle_softfloat=0f12da7de6386b2899903ca354b1f1f6d7ed7165ad5370315c75fc83702e0f57 \
  mips64=97b5b3cb6091aa840e96ee91c1823d9a6d4490b3d92caa68943c8769a585aa02 \
  mips64le=992c20e514ecbe3eb502b8ce653e2124f7278f63356be3718e40f7d6ffaed162 \
  loong64=d4599191d6a6d9c248e27b6355749d75b025fc6210a19820b73bf823152dfca3 \
  riscv64=61fd9d9eecc3ab90004c3cdc7035a51cc5a548bc61221c6d2d45c30884bb8796
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
