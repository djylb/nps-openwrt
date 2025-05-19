# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.3
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
  amd64=cce6708e53ea2170847237974d4798f2e7ec48abb77a60453f0f6e31c4c1735b \
  386=68ce4aa0f06490cd82efb28b9b498f02f595d47fa4141ec79faabe506cd1ed75 \
  arm64=738640f1f5d533742e73466ea0d50d92639c13dc456f69567d91e73a78bdf293 \
  arm_v7=52397b5862471aa2fb21e722a0b338ca0c945d99ffc0dcf66e22044f9000ba14 \
  arm_v6=9d2fa421f57f124399231b3f58e9fb20b8d8747f658ada83bb1ebe75e1966a79 \
  arm_v5=55961b2aec395089719182b200a2c80f7e0b2a6429f53e986d1ed6615473c6bb \
  mips=3e9001a395fbd2da267d2e50cb35e097eea376db66cdb36d805f1fefaa297034 \
  mipsle=542f2010c6b27c270317c5a454b3e36925608406adaa39adce816a375e95d068 \
  mips64=f080a6030f55585513d4dab8b2847bf0ee7aa12d72d912c06f51f403b257fe83 \
  mips64le=e93a3c257e1d24c4ad90224cf2c8db1bc8dc294d0372f7a230ae78f0091fb876 \
  loong64=10f87005fa1ad5a8bef98e27a79a0fdf3203cbf8e2ebc3d7f72162e1101adca4 \
  riscv64=6484676af43f475d990ed8c6028c375b3a7513ee126ec3fa92ac436ee92b5961
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
