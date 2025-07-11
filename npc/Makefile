# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.34
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
  amd64=43c6cd701e37b2530c0864cd5d1a02efeebd78e2c0603c2f72cf1c96162726de \
  386=7cc400704f94721ed15c83ce0e40a8f30233868d37123bd5b724f6544590acc3 \
  arm64=0c30ddbc88a8ba73a9021c9b56cf7fb4fccca6a3be6fcd910a75ceb3d3f3072a \
  arm_v7=d79a66ecc33d8668056601ace51f0107b0451a43b8e33ca04871825c9207e52a \
  arm_v6=711991adf17b83053b93e1eeed30717c108d8cbe951269269aa6da1a00744fd6 \
  arm_v5=70bcb6ac7ffb2ea9c9e8e78e2fa5c93d9342d0c2b4a018f7f03fbdba9d64e784 \
  mips_softfloat=bc80678d2df5add6661a01033ea97ee3e46810d4de00333fcacad90df736736f \
  mipsle_softfloat=bccb31caeb03637ce30442c226253c3634bf1ceaeca6d9a40e7114ccb64ca9d0 \
  mips64=249bd9f253921df899c21fa3332f322c6c049758480c9771adbdd49ab96ea79f \
  mips64le=f4c822ccc6e061abf489007cddbfdb654cbe3a9425109852747f9c58bd964655 \
  loong64=3f8ba29234461e7c2297016e202b048267fb6237aeb11685b4d67c59e753b750 \
  riscv64=55463bec5ad326d5b2c8974660fd3ab33508c39de6ceb9ce06803b77ede111db
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
