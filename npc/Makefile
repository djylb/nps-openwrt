# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.47
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
	NPC_ARCH:=mipsle
endif
ifeq ($(filter mips64el,$(ARCH)),mips64el)
	NPC_ARCH:=mips64le
endif
ifeq ($(filter mips64,$(ARCH)),mips64)
	NPC_ARCH:=mips64
endif
ifeq ($(filter mips,$(ARCH)),mips)
	NPC_ARCH:=mips
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
  amd64=ba68b3c7921008018fd249474b9737e70e30379342cfcc383fb85f96aca2e1ef \
  386=bc335a853a9de9d65f808591317e1d3e31322c8316667f7d940492edb25408d3 \
  arm64=6cd5073df57dbbb33eddc5a7f2bea3c2d7da580b065b36bcce4a61206a38f158 \
  arm_v7=7a5dd5be49722771fe664afc58b8304796a02b1a66a7d2788b2d641cf74e4f3b \
  arm_v6=fa08de3ef8b7c56076714184fec66eed4ee1c6d81644992059346c6798dcdcb5 \
  arm_v5=4a97c243daff7731094f0fee8e3c3b917099c376c704168a44c7fa323107b301 \
  mips=59d831df5a20f8f1434b1b31ec9bf9273a97bd5504ccbb1daecf86851e9d88f0 \
  mipsle=fce79868f6a890634c36d9ebec1756862b8d99b11fa6e0b4162e1d747811ad16 \
  mips64=b782315c82d3820b7722a4d74d699d6ba6e4380690d1c6501d2d5b9b881f85bc \
  mips64le=e7eb22023d0eae956e5de197989909b58fcfa30bd0dad9f92a93746bc1c3ec4d \
  loong64=0c4f737da3331ade74d7eb54edbfbae4be676e4fcf855828650d18fd4ca046dc \
  riscv64=0aa915f026c6131e02d472655e27cef555f0088d516d5522a70c9af16faa737d
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
