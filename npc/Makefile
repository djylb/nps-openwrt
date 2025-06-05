# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.15
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
  amd64=f53b4888a18678f0756838a38550c7e3aeb776327f98057e19a7da4490317063 \
  386=e2fbe53a0cec893db7bc34f8d93cd27a60d471e7c31f128790a78b1655f37dd4 \
  arm64=80d8e7193c2c9887158e2c70baaa173c6b75ce522f1c6ec47a082a513bbc0a01 \
  arm_v7=a3ff4059898296844e1e189cd2818708132272ec44646d94dc614c12497ee47d \
  arm_v6=67744374c55fdffd7848df26fda976a68751a2d21620e5d9229fc63de6341a95 \
  arm_v5=d1f4e1f87410846657fdf6106068b82e36de9e65960ace6305a38656dd6c5baa \
  mips_softfloat=f1027b0f963a60d47db269a8e8cbff1cf2da570f00fdae38e142a81c0c680794 \
  mipsle_softfloat=d24f596d1b258383f2576060d9a4b2f3eb620295dd5dc1c0c77e427f45ac5ab2 \
  mips64=8ab027bd6e859597c6300eaaa4da4c69e00b5fd8ae8a5c8b7437dc7deda7975f \
  mips64le=266dabd1cbfad56369376202c1c0f376e0aeaa7e6b7cecfd7dea4ef71b6719c2 \
  loong64=cfdc14e7b7b6e45e56750a7ba5abadc00151c0edf3646632982b045dea1afb21 \
  riscv64=5f917b8158697aa888c44de4432a4a145c56a5101be1b5f30d1a777dcc91ac51
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
