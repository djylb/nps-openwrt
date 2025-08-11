# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.3
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
  amd64=5f85c3602785d36d77239823adec0f8c2e9e407e8a53460002a92eb96a3ee82f \
  386=28cb4b287e2d054ba2eee1cb690b1a8e56e2fcf3a9920d114f386dc18a7c947f \
  arm64=47633210c742c91efb5582ea28deb02a283f92589d73cc4d89516b9473e12ed7 \
  arm_v7=b51bc65f9d69207a51b98a14b6daee5cd42ae24d0cf3e4834ac0d8eebe20aebe \
  arm_v6=5aa2a02d0260467e2aaa693bd0f21cd77c4cae1939ab14bd71f14e487b990d8b \
  arm_v5=9d9b60b38966a9ba48c44ebd05996859c47f035ae015cb9aa45433de9b03ebd9 \
  mips_softfloat=1f349ec33f1530187ec96d68d521c47d4d5d15cbf5b0d9ae4a48e970d323b4de \
  mipsle_softfloat=1cbdb4f4b55399ed400c45d0f3713fc3a25ea44401d3edaa7ea253be39ae0998 \
  mips64=bf4c22a53b06c2d6bf2d8ae98657f5876d2036128aca84890787e07ffb1ca2c3 \
  mips64le=bed64503edf8c7340b91ee8e2eb4bebc41979098dfae2f4845bbbd07cac96e0e \
  loong64=845ff13ccbd6deef15fd2ac20b0116f08351bf03a694dee0e44c889950caa243 \
  riscv64=924622e1edae03223550d167a169805e7d7231547db167a4f491debef880d333
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
