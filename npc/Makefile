# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.1
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
  amd64=c814597eb933ec28c23003f89a055d28605ea9737f3bb1c6d4a0f0f2215059ef \
  386=213bad2013888110cf41b81c89afd179b59fe1886847b04a63f5c569e94eec5c \
  arm64=a2d3c01da50ba71aa3caf6d213beb7577d7ff4a4adc70d02c2f81aacd67f31d4 \
  arm_v7=ddd0ebb54d767f55347ad265a60e58267f0954f403e239d7904c33343f79caa6 \
  arm_v6=9f9c89d9329782cf400dc5545bfe3584b13cecb78f531c0d39f37e0f0426abc2 \
  arm_v5=baefa5b943b80e20f992d96240d639723ff0210806ba71d3eacd85ebdfe9672a \
  mips_softfloat=0e8aea8efb17088cd17c74bd5d4af62a9227e8af9c4848e1db30ca7119f88cfb \
  mipsle_softfloat=6b207375dfc3a7b4f8d2151760ac6b2612a709251e8a3fd1dbd666cfae99e419 \
  mips64=5254bf14d28f781d0446a447091edeaac24422a3118370b80bc8637d8748fafb \
  mips64le=ec5f4e8a8b7ca1a903acab2526ae3beb9b1d41447aa3e9b8793be921361b44d5 \
  loong64=18a499171a79a8f06cf42a172e2315b258aca925d0d273522ba10da02bc2d65b \
  riscv64=1bfcaaaaa7cb0ece2f188c13320e8c06a43bb65fcb2f4af372bf63418eb80237
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
