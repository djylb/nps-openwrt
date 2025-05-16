# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.28.3
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
  amd64=d59f45da58dbd4391ab1a5c37259a84bd1935685aa8715e6f71ef1a3bce3021b \
  386=4c2bc8374475d6534637bce545336496491014926f5a359b6ef7aa279fb364d5 \
  arm64=05fa40dba4b4f406852a9d915210deb86e5e4193f25ebd4f9e7f9a2591e3e2f0 \
  arm_v7=969eb856a15d5899e5d5f9cdb75b9b281afdc61548b3e70aabb451e9eef70bca \
  arm_v6=09846d5c213c8115c45d95d8af99798ae8403e905bcd2326c85238cd24ec9339 \
  arm_v5=cb67d0e6777bac8c1a055ea6203e0f674ea2eea46b4ffaa500af5d65a8369514 \
  mips=7968d5d1233d20b48a5baacf745c7d5f9d3957d8247f286b76c7317dbf788992 \
  mipsle=e49e3aaa3967b7241639eb217e960e72e19fcef413c283ab49dd075654537dca \
  mips64=b7cc219a39bd60272e011c45f9ddf5a99a11cff92b796b4701c74e34b9efdea9 \
  mips64le=6b340d88f317e6aa16b5a4e9e11cfe5091ff5ab9c15fdd287ddc72a949ff6398 \
  loong64=136765e7b783873f5d68e59d9c9fa0918d4cbff6a6c3f0838367b160894b8a9a \
  riscv64=e335870e207b58df1f36f9da04960b1f8d024aa0ccd9f2ca94b8256bd1a19b3c
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
