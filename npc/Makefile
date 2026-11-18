# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.35.4
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
  amd64=42f337a1ad1b6b0d15ee16c4391f6cd252340823b3ad33a15c4a5fbfe19774c0 \
  386=df5f4699726f41deb62e6db9160829d925e6acd8f4a8b5fad7746204abcd51df \
  arm64=cef987f2e4192e106b3f15ccaa160f75ea45672a35ee7d4570fe566786867fb8 \
  arm_v7=3ca9837d280624b5c4a602c2011f1b5ea523c9bbfd31cac1fd01dd22aeca1d0b \
  arm_v6=2ec5b445f4c92a386f61ab4d9f53e754ea61b5547e7772c558d164aa5e60ac52 \
  arm_v5=0e21a4c34370f1acaaab3212a14e1f1451385e88971877f2e10c3859516d5350 \
  mips_softfloat=c4f5338d82e686c1c3377004a9e0787c2b3007cccb715473680cf2c191a345c9 \
  mipsle_softfloat=413c2be1970e071ff323481d7fd1177a9cdf81f2d8d2efaf956770b6d86cb1c0 \
  mips64=5470bed0ed59112b2cb8aeb915bafe16e28d52539c957b6ea3231527ba94da66 \
  mips64le=054050128f4d93f65b3e1bec96b2f0c5c0acaadfce17edb9df9d7167c1411c24 \
  loong64=60aa00d062ebd0fbe2d771efe7d52f2c25f0e7f8a6c3e19a7a9f701784851c7b \
  riscv64=943c1e4857d99e9c5e7f17be66baef36cc87515dac40d2be6ac95059edd06860
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
