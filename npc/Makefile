# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.1
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
  amd64=34a2f7d483dab2795ef4eb9cd1a0587ee7d8efee9b019b4f39805aed5337b5a9 \
  386=32f9c8f3cedb64d6a81a66c312bfd174ed818ad5decdeeaa3168978f13b127a6 \
  arm64=c4a3255c0a60f7ded1e1fc83f46b5ef9b66781b16963ef85d2f15db1057e430d \
  arm_v7=dc61abc357ae0e77d5ec410cb0ea79c31a820ad877686c2cded07b7e57ab4821 \
  arm_v6=b547f0c25b486595923e758ab3ff925840ee374a023aa47fe6c6698f97695ec9 \
  arm_v5=75458ffff1f08edf4f0771ce59ce04cba49662c2862403798b2af4b63e0c579e \
  mips=32506aa50fb393738e46b915976379d82bd127e6b23b4637e98593de3d5d1892 \
  mipsle=947fe84665da3a8ddc0a814d5475d8459dbec60aa7ac53909ee1d9e004c64bd7 \
  mips64=85e2520d7bd0bfc6b7795fbe72404c4aaeebdad2481b38885796c282c1eff520 \
  mips64le=da126b4b636f321406deaa4c04193614e7fdb91ca22ff3d6a2952b914474046f \
  loong64=7eeaf13c263c161bb317b6f882b4696db4ece18013c2036d1b8998bd30c32737 \
  riscv64=12d6f9aec0b594550991baebbca6fbdc4a81d64f97db4dc289bd6b29489af9de
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
