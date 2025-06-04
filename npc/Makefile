# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.14
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
  amd64=406688fecde8bebb1b2bfc36b1e08a42c4f4a9ddb6aef3641d71b5e10cb9b048 \
  386=bf80a1004af26f7f850feef9878b0342821bf865e0a20fdc94b6437f5896f688 \
  arm64=1b92f086dd282397475c8ed12f07bc6e8bffad02877d3d0090e8c2fdc530764e \
  arm_v7=04aa1ea68c58559e5a641dcc9a046384026d4a4d52dac196098d886c7ee28ec0 \
  arm_v6=5f2a711d4ef11f8aaa1912ea4d86e08d68f8a5314dce3fc4ea469811080f4cdb \
  arm_v5=b5b0392ed5fe2eacef4e6e349c5e24566a04fd7e3423132aac8ad5951102b106 \
  mips_softfloat=1b5755a59689dc2242154bc18afd836824201bfbe3aa94af6ec62b657b7a4aaf \
  mipsle_softfloat=3f9abea9c639d33ada8d32d15fe12b972f3dd383b475d240a146ddbca9a96d3e \
  mips64=75326bc0b542dc10c58cdf63bc1cf018e08dc5dcacb21c7280f565996df95ab2 \
  mips64le=2ef9c75414af8dec47987c89e6f3be45bf90c16e60f1249681ebd9f034c297fe \
  loong64=f64406f7f8caab618598d06e3b86ac40138ab042cc00911903031c9214c43d06 \
  riscv64=9d3485644ec8f5dcfcee2ab55c28a3e25718005379d3d3bfd3947421b8558570
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
