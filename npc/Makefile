# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.47
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
  amd64=f440f6164a640bdc80424eb810c24b191c2136c9ce165a2cf9bc9a48d2d61370 \
  386=d7321e880903a5e2ae16775b789739613784fb40116087be814ecb661d5f452a \
  arm64=bd4472043b569f81a854c830541acf08cc0d091f99212edc46211d75d738e7d3 \
  arm_v7=7e24440e24a590b67f06851fccef231ab4b9c7d7ae3af9f25dc73a72a8c2871c \
  arm_v6=e1f08c11c380abeacbbccbe4bd388f97ba3e21941704d94c262019e8e187be2d \
  arm_v5=33414d8bae12c9e143453c021976574bfa7524474c5d0d3ddbe848a6fd3f986c \
  mips=43645054499c1ebf35da86e7699cd088e38691f10fdef8f2ba4051657218c323 \
  mipsle=5ca7f416429f29736dbaa4915b05e4fa9e81c1fcbf7dd77745a257ac2c8167e4 \
  mips64=2a1ce628e4dcaba009a1f8c131f00eb22823ab3dbff31edb4c4cbc1d867d1e90 \
  mips64le=e839b12b3b4c72c7a60d9258a775bc67ed8b4e164240ac48cd913956c83a745e \
  loong64=74470242ca3c3c71fb4202c4a3815940c1f377149d93d6935883e03ff6464b27 \
  riscv64=7f2f3fa51223637192205c8abb9961364516ba96d64c7c6a38c11e3c0b4f520f
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
