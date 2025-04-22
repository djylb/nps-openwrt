# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.51
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
  amd64=dee3945abb86562d4fe0b91cc8ee16917b56bb9f7255653ed2e28361aefd8728 \
  386=045138166a6a3d689154975135268e87dc5dab791cb9fccb8993b2993f550364 \
  arm64=3eb87cf7b5e37eb74423b084cff694e741b50aff19a53fb5d5c628f36fcf8162 \
  arm_v7=a0d317462cb2b963a4ce34562876f30da33baa2564c8312a3f2081bb7737c152 \
  arm_v6=d3b290b98b5c6178f74f36eda4b9036a17cc33d6adfa873f9e83ae593d501a1e \
  arm_v5=010980352d6cb4a2b24f06d24d65074c96d1d11001e85d4a0b796403d2c4fc4e \
  mips=b367d154d2e04d97012f636fbbc69b63faf00c2b20c6dcdff63064ec5015f5d5 \
  mipsle=97c53879317ff0d2c1141b87049a1d4ee06b395b79c9f10daf3a8954edf1ce47 \
  mips64=7837d9af302acea2a9aec1fa7e9bc9ebc1baa655290315d1a57d68fc8eda9da5 \
  mips64le=6470b593a8b4e6e286467931d357f116315634d1bbe8263582f3d975705e2b2f \
  loong64=67ce5056362c329a6566ebb26f6b79c147b5bc6fac44879579297a23a11f3bba \
  riscv64=337f8ed67673b100dda1622db8c6015f65883a1021939c94ea9cf66c99a23afe
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
