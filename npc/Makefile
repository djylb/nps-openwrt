# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.10
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
  amd64=96cf676b3aafd4736de618e73fa559964c2ddcd5a1a15b811b3bf8e81378d547 \
  386=dd7e6fef3d9ee2059024eade3e96198b96f012e0d1c5a6c6e48162ede1cf3221 \
  arm64=f8f0eba506f43c2bc109b3a10866f2f4c5937bf6f31c87852446a4fdfd216811 \
  arm_v7=0bee97803fce6ccb947fb4d3afe42aa376a94d272656c8dd7cb72d1e8dc1d6f9 \
  arm_v6=49a8c1a41f254156093fc8aca24193ec6cee1d12aedd7d82df9ae9a05c88cc2b \
  arm_v5=a269632da04f2e0e6792a8257a67285b1510d63f8c926741f25e18fda142be3c \
  mips=b71d706e110e02549ed10f62198772fa12a7adbe88e713b2690f552c9031d2b3 \
  mipsle=bc4b931de1c3adb73453b4d1134a9c2018bdfa6f58d3850a04dd4bf36672dc60 \
  mips64=ce3afbb1cd75055ce6aa8ae5f6c8fc9beea2903f6dfa5c46df4ef4c1f08ce636 \
  mips64le=90a47b68941378fa69ac89fabd2c1e7654ad65f9c65d288bbfe576f49cb26a19 \
  loong64=36a039f60f7a246938f139c4d84d302bd79e20afce97629040b780460a76581d \
  riscv64=ed19fddbf4a1c9dcd8fd141359bef91c92de471bf4e9026622cbc9254171198a
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
