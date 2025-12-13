# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.12
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
  amd64=84abd9083b4f3e5e8978fe742a7499b9530ebd910a0f06bc04e2bea3688bb61d \
  386=64c00b1e744d028f8008a8da737c2e1ba8a015b86f6fc939e168e90fa9d6696e \
  arm64=b1df5f6cb1cd7abd4dd62ab0c3cc8247510f6edde12ca7cd877235565cab1681 \
  arm_v7=782baa090217060ed78738b294867e6a61f941394e261ec76cd722fe6fe1f5b2 \
  arm_v6=79930017f318b8573462c9a1c6a48b0f72c6410a46c42ab644c3e24bc009af62 \
  arm_v5=4d3ac2637450f569864f372bd7a01673e3a0ac9fc895fa59d8b7e33179e6661c \
  mips_softfloat=887ddc171aa1dbe3e46c23e14c8daf53e823ef315c7d78a07230daf4c042591c \
  mipsle_softfloat=d6b2a175603dbd09bef7c67e0387dbcff70719c956b62f9624a008965f856fb7 \
  mips64=cdec6331de4569d778543ab93668cd32f8f6f5db95eba179a3126100f25e4a48 \
  mips64le=14e7e497c1f808940805972876877e7e00f5b66721b691f0b1612ab1fdb82201 \
  loong64=3312ecda23214d71f7cae16c0f2cae949cdea535476e8c379a9b3dd8ba89036d \
  riscv64=1fe20902f68c65304925f6f955ebeefaacdd8194adfffde2d9528df6ec5262b3
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
