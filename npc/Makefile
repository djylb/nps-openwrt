# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.14
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
  amd64=c94452e7443a08f73f23fe399caa450fda31cefe6218ae6d0f035368f9f90a7c \
  386=64f1ebc54cd49bc90a1469100fa4fd97d55f863bc7c25c4b8822e811e3fa3ef0 \
  arm64=c6086624154897cfbbd843aa8d82bdabde72c120bf10721b8621a8d2c4befa6c \
  arm_v7=0c43824dbd45bfc64404051ed8b8c4c485387b397664ab0cd4f35f843a2a9022 \
  arm_v6=b4c65620aebbf9d508c7dc3c03530fa67e46aa86d9e7f65d96680fdb2fa33032 \
  arm_v5=75229ccd930cb148f9dcc4e4dfadb3e97942a8a69571886ce290e17983c788aa \
  mips_softfloat=ae340e339018161ea975fc2480bad503d1cb8c75994bcf25c5a83b18737e95ea \
  mipsle_softfloat=48307d1e549fd2a3b5eb4ec599b24ea7bfb4f2f38b300e752d6c488304e2d71c \
  mips64=68a45ab2b65468de52a8ff52ded2b0838a41842497260a230adcfa29d3039464 \
  mips64le=262a2326d7e11b58066cb0cee41eb2a744f72f112a0a62f6c6ce852af45dcb02 \
  loong64=e7e819acb3b8d4fcccd6aa687bc7e743160ca5b43b7e0f7c846ac2b4b4fd01b7 \
  riscv64=44383830dcd618ef1aabc95a942f4bacd0c3e3c1ef32f2e99a9c46b140398648
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
