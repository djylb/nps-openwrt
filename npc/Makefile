# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.25
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
  amd64=6d53b694172253b68b2f26b936b36e088b14507593e83ae784cad167e9f72b9f \
  386=cd3f0906e078ccfdcf8dd1cbe771177f239f7832ce382f0bb703f41cf53f3d91 \
  arm64=5a9aee9c1412d64fa740f9e9777802c84fb398c9d7c7ba726027e08ede68f8c9 \
  arm_v7=fb88c8adb908927ce8aa6d84ccce438079c1b1b8c864397c317b372af30db927 \
  arm_v6=97f88489b1e2f512ff2f1a72b2ddb3ec7c73b11cf8cc3a1825d05eb57214e896 \
  arm_v5=af0fbbff25b2c424f229cc00fb9512a19e08cd8ad468cb30b30ea6779fd8ba60 \
  mips_softfloat=02c1868477842ac4165ee1f858f9c180319d52daab7c23abd70f1feba28b42c7 \
  mipsle_softfloat=3d5c3f42b317f097cdc2ad386cc5796c384e242ed8217992177327e07e9255c9 \
  mips64=176bcf53b400a0828368939936f1cd904759975998e988dabe816bb08cc2a0b5 \
  mips64le=544d9db38e28be9bca09c07c74ffb8c8a4a9f1613a49e1690424dbad802529f3 \
  loong64=8539e127d93e61da47c02a195bb572c21ce480f9db1e8fa6c5e1a1423b805b0a \
  riscv64=cea0d90f5878a13e3118e673cb7859608e0f2daf9c9a326f21c075fd38e0320a
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
