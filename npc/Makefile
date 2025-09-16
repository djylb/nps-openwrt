# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.6
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
  amd64=d2da27038ae2d508a6c6f50fe859f6c8feea6499f4cc2c41b718c5c77a1f048d \
  386=819ae90f06138eaf8f29a326f6123ebbf183c3c0bfc597adb57ad390c44c8222 \
  arm64=018de96e8a61e8f20147b8518f470f1e30fe1c9bf0964b7307a23bd895689612 \
  arm_v7=07d26aaf1aa7f3425c3051e54c56a494f412586d634052c7572f3866ac807796 \
  arm_v6=a39ae95d1885df70abc8c5c7489bf57a5da6c86e3ba53d9a5d3407496f47728b \
  arm_v5=6381593d057d03488f956a3e6f9fa7fd1c928d8c80938271813c26c65d76447b \
  mips_softfloat=f39156dc4d57c6f360a3f2bb9367804d0b1d97aa059b4a7b1b315da450afcf40 \
  mipsle_softfloat=b8be3b31ec6609fe20f8d747ce5089fb66b01377bbffda4a4c469a81136f6b57 \
  mips64=8da6fcc025347b2e7dd465bec9a108fbd3ccb820558ede19ea6eab5bf0b42eec \
  mips64le=ee44ca2056927e832d85985c8056d7b82b33ce04896fa45a7305c87924cb184e \
  loong64=d43b74d8e52ae0aff79e273cdd50ce4fd1e7f5c8d351e8d4444df4e3874291a3 \
  riscv64=b2f635aa896a235d168355936c8c6dbee22fb7ea96b0ed101bb54c52440c01e1
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
