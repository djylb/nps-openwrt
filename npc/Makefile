# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.20
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
  amd64=61c11a961817ffde9224057f71634385d8860e487801c9b8b7edcb3d6235707c \
  386=1a4efae6e4eccae6af4423fb35316ea4eae6e3972bc9bbeae4e9576cf760e7a4 \
  arm64=54ce3465b54858e48e705a36140d7fff2aa65f59985e0cc8eebbda2dfc84079c \
  arm_v7=1264ac0279ff86584559cf41fe725bac2a24d4d7b02e2f8afa334f1229adf59d \
  arm_v6=d833d3c02ed4fbcea0485a6513ce572049e7f9409b4b103b41b8021ca37c08da \
  arm_v5=8c37f5ad58a7ee57412971380396cb6f2bebd37c96e7e8f18229d3e1e86ab4a4 \
  mips_softfloat=4234cd662600a630d106f8d8f80a6e17299c92cddf4f7416b51cffdd8201e265 \
  mipsle_softfloat=f6bc1c38f192269ee8a3d803dee6cb0e4b8006b78c4c8ed6f06b2ab5c09a0a56 \
  mips64=00ff254d07b4c6d36a11585f0cc2200b0e8d76240c7f17cd2f7727a48ab21572 \
  mips64le=5b83466698a2e385013b2045d44239347dbf48be88d625942a4c19bbd77f31d0 \
  loong64=3560a2e44437ecf4d6baf33eeae4407547e02735c7bcf1792bfbc6e80102302c \
  riscv64=aa9a51237ab82958d97682d150e63f8099f40987e5d612a2d4392053a00b9c9d
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
