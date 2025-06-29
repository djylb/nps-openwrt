# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.30
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
  amd64=96804e5a60ea48e2dee3f95be00f7e64cb5b69df93fce5d7cc39c7eeeeb07010 \
  386=e44c442ac73341fe3249734c8731933ed7f434110e6cd0ebddd6760de995a237 \
  arm64=9a790984761601a2407cf8b546e44fabac7c14a69b3c967ec93c70d7999bb462 \
  arm_v7=c9d9d1a3adecfb78a8672a68cc41914dd9d32b249c92b98fbc7b8806334e89dc \
  arm_v6=df0fdca6b6e146824e742439f2bf9bb60690f2651735a22e12657a812b1801fa \
  arm_v5=b216f0372f0565d4bdaa77658eec4d1c419b6aab60f78d416e96842dfa08fb69 \
  mips_softfloat=6530cfe2a28cb3dca11ff330e555e83189a3f0e92b98bebf90b4435e944387ee \
  mipsle_softfloat=8085493fd19c74a431c1f44627a2690a48302cf2ff237dace0802234a5c9d220 \
  mips64=e69dc97e395cc277c3a36fa426b427da5516ee313b9e0b54606b06f182f518a4 \
  mips64le=4b94af4b5b3d25ae6d68c6b1c742249221817ee59c450d933189aee36f6742b7 \
  loong64=2b73e26f7cee7e869c970d8a534b3f3724c45fef326e6a408020af7dc79f461f \
  riscv64=9c001e761fb08c3242653d94aa3da2adef2b359844bbf9013134136a99f9399d
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
