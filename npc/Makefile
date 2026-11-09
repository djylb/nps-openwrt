# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.35.0
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
  amd64=57428999508b9dbdf05dc78b6ef57ef521838116c112b53e5bec593c34bbb541 \
  386=26b66a4d5549e1cc87e968a3fa029ea7d8d6d0f5e0b6ba4929176c115fc01cc3 \
  arm64=8765aa1297c6009250dbdfaabb1235f4351f9853dfdebef13074e6e12dd16cfb \
  arm_v7=edbb5bd7fcc2ec276fe40b83e26b27f22737e3ab8229d17157fa511c940e0e2c \
  arm_v6=eec4c07b53722cfd42c9cf7046d15175c66f9e26bc201f53e9aa48b5d4c68a3f \
  arm_v5=85517a93bf0d6ae0bcacac8c2b2e6918ef9680c6c82c8aa5bd58cdf65ab9b6a8 \
  mips_softfloat=db40439d273ed12d9890b6a1a874176be457f37a7cd1f34589bef98574505360 \
  mipsle_softfloat=cdea4e4faaca49d0bc27464620fba89e02b7f564dace67ca731a7c5ca0251802 \
  mips64=df53ba64750969f6b9dc184b66d02d1badb2bde56a3f7a6c7a3b855b86e9df66 \
  mips64le=17fcfcfeac4ce8daf606b703305b300574b198f04afaa4780720d065c45582db \
  loong64=defe678743cdeae2eb2defe990bc960e2273e8c881d98dff564b713986f81553 \
  riscv64=8401405e3e0cb8b2e89312b9755789424a10e5ef7cd4395d712cd949b03883d8
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
