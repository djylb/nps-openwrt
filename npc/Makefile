# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.46
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
  amd64=1944ef89eba71fc582f21e78a23429c6ca61ea5c00aef4656f336d1c3bbe8ef0 \
  386=63077d51a575f7cec37f8c3cd2f2245a2b772df2dd142cf084c4e0af297b7f4c \
  arm64=aaecd5ab8d96db35cf71ac982c395282e63d1df8c12562710de4b4f9e3faa9f0 \
  arm_v7=1fd8463d2f2bbd4d33748f57e7c1a3194af1f679a419c5f7596206fe7d841d33 \
  arm_v6=9c4baf49e86cf67b7031c457a8f71788a9f991f4a4b897ec8b75c60bb0d741d2 \
  arm_v5=3fab54e5d3e3164aa2376a6d56e2b337f860af32388df8f7cdfafca13d64c91c \
  mips=95af77f85f828d3e4440902fa2a610f24506acc9d38b9e203321c203eccfe5c1 \
  mipsle=f1ebac1317d3adf858065c061faf9f176aa61c4ff7db36b9f02afff0f9a641c4 \
  mips64=e8de952679c7bd2fb24dc631f7e441d7f7ace685a79f936ea8ec1d720b2100de \
  mips64le=359f4876b5ee7dd58cb77a93d3a7a2205b4308e951840aa13a346e295b7a1db9 \
  loong64=d738be56e25115ac646d2eb4c2f5b50676f9e92776e1ea272355bbead2a7048d \
  riscv64=79f87fb09c0eb015d54078f2b69dfb8619d00b36a1859f521e651c407bd0b4ae
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
