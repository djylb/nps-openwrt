# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.5
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
  amd64=f230eedc58eccb3b0b5f2ad7be109754efa68f512aeb099d33a06ccb6ad4a033 \
  386=045f1a27226ad5f2fec83d0f01cd97586ed422270ed80984849dda05e3dc0021 \
  arm64=4204c9317b06c076d9fa19731130926a780c26fc9817ea16d0f53b65ec3b1930 \
  arm_v7=1060d4dddcb0a63f1681195d4ca38a851f45d46d0b9c93c82e6665ae070bcd4e \
  arm_v6=e612a666038c3c6bbee0ec904b0c382c346254198bb3393f2239b99e6359513c \
  arm_v5=e37ec525c957476561a15c085b18e61127545ab7136c0cf28a8c192d8f4b483c \
  mips_softfloat=934088c46f882c8563b17348bb8fdbee3ed4029262b505bb1beaa0267def96ee \
  mipsle_softfloat=784111bbf98194ec9f9390d43d4e1d6f8ca88ee6028b830f09c4f5565c56fbf5 \
  mips64=b6f3e01df5fa5954f7f185b751eaff2e48fb35b7e8f0e6b49b93c60051edb934 \
  mips64le=2dcb59a290481197dd520317bf38bb18192c466583c72f4bfa191f8beaabccfb \
  loong64=0554a0f4808c4fff2e4b325e9034a3652d71211065567da697201723a601307c \
  riscv64=4d2d1363c3ff489b6dd1e9f7aff9abb793f9de508a83bdfa63c452adae469b92
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
