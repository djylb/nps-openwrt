# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.48
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
  amd64=f0cc47da05b43293af1ea908963f2691053190b70c06b3e4ad5e717b4c29d490 \
  386=f695355cba0037d30fa32cc032d4ddc7548a2371b4cb5f9d0b50dc86f106a3fd \
  arm64=e0ecc3fdb37165cf89380fcc57376585fc69c3f669053d1796203239b9c27f50 \
  arm_v7=f7e465fc4538c98aa875ec1f2dacf3291d67d3f9ad33a49064dcad3464b9a513 \
  arm_v6=fa2e2860d387697de56d3e5d4bf9ec7038b945bcef75596095a0898ccadc4e0f \
  arm_v5=d9f855d15ad530e0609ad40339487ab6ea1c1ca59be1314a8389cc03dff8ce0f \
  mips=3176ce5c796c590c6c9911b2a6917685357538fb8f4f2e6aaf2546906bdc8125 \
  mipsle=3a2e7123da5c3da080ce84cbfb06b6e1560e7f07d8ace50c471fe57938aba460 \
  mips64=812b3631202faecfb684cd8faa56f37ba0f63726f233c339800b2671a0682495 \
  mips64le=8c0d318f837a9c1fdbe82eec678e3e8c323148df11dac2fa7a0f80a3c531c1c4 \
  loong64=52b67e9ac5b73a29d609599e5b684bcbcadfa78169c792b379a8960cada8a7e1 \
  riscv64=e9e10472b6049cf5643704543f9bc043367c1cf748178e21f69f1d717527c1eb
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
