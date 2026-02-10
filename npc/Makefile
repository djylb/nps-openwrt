# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.2
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
  amd64=ee9e4c462e8aaac52ee030ed2883c44facfaa21641b1b03d45c47cf1a6323876 \
  386=e5e3c533828ad124a8cf03bc8d62dac1c6f26a973e95e52f35d4ead7428057ce \
  arm64=497b33dbacdfe26f163c3eefd58856ec81a78cfb513db728b8b88cefdf204dc5 \
  arm_v7=d49979f7b8d52581af2d6efc9a4f7857b7a8081c334b51b33fc4e060cf5d92ae \
  arm_v6=7d5de45bd342a21b477fe880fb28de58efee481d0a213f3461562232b9ed1672 \
  arm_v5=06673ffcf62cf7e81d4874bfe2d25562a8d858f2005050fe97e5f29fbd89cb20 \
  mips_softfloat=50d8354bc2653030f8f1fc759663b2c6bee6d9c2a171f069677e6e3391f902e5 \
  mipsle_softfloat=eaf22e4feac84d27e0d7f85a92a15f152700013ff12fb13a686e6d3065dbbd31 \
  mips64=b70c280c3fc748441505e772879355d79e6e1914c31171cc776dc4227cb2d1da \
  mips64le=280190d4bbe111034f9736c884e529b211229005bd9bed9853c330bf1c77f2e9 \
  loong64=b5b0dad704ff440c157d9ac0b24c2d0f45b1b2a7041c8a3002db9bedb7771992 \
  riscv64=79c44966bc0c4bf799f91e3e88cd0c78089267cbeffec9160b10cb7b5307b476
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
