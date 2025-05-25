# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.9
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
  amd64=49f36c795b0025cd804c49f085ba949aa36eda5ec88c1aa58c233cddc819aab1 \
  386=ee15ce926d3fa3419972cdb59ae3d253d507452cb3c4986b925d824debac2ef4 \
  arm64=40c9ebf9ff66a29fee446b7cf966f3d8e775631125d9a8ec73dcca40bfa3d33d \
  arm_v7=3bf6c3fdc288b7fded8a8ba54f6acf399e69d7ab1dea65ff89ad046fb5c53ac9 \
  arm_v6=26ec1ed7e7b7700c683895880a68033d553732d16414f06c00955bbfd609a204 \
  arm_v5=b04cb538c107b522c2a28846e17f97ffeda125674a56a8cdd7d88c725f986c98 \
  mips=39f418673829bb145c129cdf2c6cd2d7db84f66a7eff28fb0823f9d6365bfc3d \
  mipsle=1fa5ef4be873a95dc4a85533cf5dcf5ef03fc0a0836dfd7e78c281be24a02147 \
  mips64=46e8145cde9e9a39048049f50957582519968490e4057c6ae82b3b684c4da63b \
  mips64le=36efee5d4456d2ec53a417030ca4a0e70c0e05555cf1c86585b45e3e51f92ce2 \
  loong64=ccc5b278679b720975c25793dcd0de6e3b69512131b698ff6dc0254de7dc336e \
  riscv64=84819ba6d5101bacc4956d4feb8af25c18ab0650ecc90c8f57bcf664c17240b7
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
