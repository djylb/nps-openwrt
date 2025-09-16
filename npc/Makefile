# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.7
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
  amd64=d53b4dd0ebe702e38a56e3b260ee398d777313f454d09f5270ae92044921a58b \
  386=a7ed606d9521949b1148988edd69139793b9f08c02cb28d3218bcdbb8b10c302 \
  arm64=de442a315fc407e57e25dbf32b30dbc18975efe21566308cc9b4f83927515bc0 \
  arm_v7=c72d6e464feb088254cd241e7aa5f4b2add585dceaf2b139b67c63f5626d0cbf \
  arm_v6=f09e38fe515b628f68649c7bf8962d8e3a4d2fa4cf9f7f34884370b2b58202a6 \
  arm_v5=e604dcaa0adb4823a39721c8b0f2734722d5d8c1c7ecc564c13c10113eab8fe9 \
  mips_softfloat=55ecc47755b202461152a1f2348612d5665793cdb3625bfcea4f8fa5eca7f242 \
  mipsle_softfloat=e9bb1df2ab128072a77456de17079a284788f7f8f584e0f19105531164d30d58 \
  mips64=afc0f1863b3e3c9cdc1c8b788c6588723ecb20c663da1cd00dedb7dcafa5d8bd \
  mips64le=47817d2e2b3ae090947b7fbc3a16aaff1cb20c799dd6d69dab79e77812d0e342 \
  loong64=ec2f3e53904514a9ca53e9b5d78dda7c9abc1018d20aca9084c217b7b6c0305f \
  riscv64=61b704700de81743ccc0549bde9508ac0ac888fdf07656af65171fff628288fe
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
