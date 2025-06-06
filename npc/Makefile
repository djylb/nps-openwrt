# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.17
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
  amd64=436ed726fb95e5cceafaaca7e87254da5adf010948db9bbafc13e55dde8019fe \
  386=dddc3d3dc0c4be6a220d2a8d946c2c5bb3639af92aea0dded6ad968a33d7c2dd \
  arm64=53e33d49514d559c1269bf2fb9f8f2edce040cc2abf00fbb020299466f830609 \
  arm_v7=b29850701a8beda6373e8b7632226cb164b4d2225f040906ef8bd268e9660226 \
  arm_v6=77134e8891663d301e556e6f71a24b70872283e559f5bff38b8c1004954eee91 \
  arm_v5=f87cbc52bfdf10bbbc3f7161a3cf7a3b58714c7ce0b8decff3ca2d286bc10e7f \
  mips_softfloat=7e0aed542bd4928fdf69db1c243b7ba2fdf906d5176c038a45dae06229f5236e \
  mipsle_softfloat=b393aeeef819b133ee34e72ecaa1fc362795481dc163fbe56fded9698ba0bd64 \
  mips64=ce64541dfc8c3a25d340f59b5097177aad5467bf6bd9a40a55635295c9d38b2e \
  mips64le=893c5a0fbd353ed4faf83ad909af94769971cec2834009f416ce76ed98c7e71d \
  loong64=e05ff21c5e2774ca783d4a39465759259008cdbc2a6c17b8793dc44245fd2686 \
  riscv64=258c7bb9d85b6c462eea51ae71bacc00f71f6937d0d112c37af71ed1dc5ead0c
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
