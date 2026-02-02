# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.1
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
  amd64=b8c77bd07d83aee09b543d5cd2ce9bb700af65736e5bc598f47a31e4f57279cf \
  386=2dcc283f0097f3fbfea5d3681229195d7d19d787da586ca626442435d841b908 \
  arm64=5b5f6877cbdf40f4dc9c1edd49c3496b8a8ec1994c51f7185837b12ed16a3dae \
  arm_v7=bbc16d9b55b1742400c4b87c760f7689302ab006efb8a99de37500c05fa02ce0 \
  arm_v6=99c6f8e8c10ca2516c23bd39751dbefc0af3b96d01ddeeff4c8762837e94c9cf \
  arm_v5=a2d35be531c5319e916ffce6676883362b3ef1927578408f69179b90eb99d3cb \
  mips_softfloat=17e0da94a588e0b2a58cb44c4bbb1fb306ee911e13c10203080640eeaa5058ca \
  mipsle_softfloat=faeabf14de35895796899cf1ab43d6b4e4b583237b03d798d26df9489e3dbfb7 \
  mips64=7ca68250b2bddb4c44e579334975ed243b6fcc1cef68783fccc96a61114b87ca \
  mips64le=a849fe3282c5a6b3bf0385f010d5be1c44d0a77a9bf11c737914eaec9209f578 \
  loong64=f48b6ad0dfb5c623883568cabdfe17eb46f3d81dbbed74fd0dbf83757a5babb8 \
  riscv64=411beb45c17cb87f2959215dd7a8fc0139701ef3ccd220d15ac45f708c98082e
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
