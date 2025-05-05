# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.55
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
  amd64=b24c7087080fc10a05eac5e2ccaed3f5502a97b8bce31cd58b09239e82fc9048 \
  386=544a68ce0a62e460b2339bad1cbbaef0802bcce367a4391c1767ad4ac51c1619 \
  arm64=57321047884ec4867e7e7b4f6ed4c4b8299640ffc0e7aa3835b31f01e272972c \
  arm_v7=a14b33542cdb178ed41d13e9bf7c18a40a7d0f4a9e57c813f8e3a9dff4a070fa \
  arm_v6=49ad62060aaac20e45e0c1b3a4daa56d521d79139e228e087780b98e481670bd \
  arm_v5=8b30a12254db9136f5df1bc244de9e543665cc7edb974d32c2845a15e0843123 \
  mips=74309d663dc75aebce7f7c09f2dedc7aff180f2ec3b2ecca8bc47ea9b6522382 \
  mipsle=5dd0e7bcd5790cb3b31185045761aba131228f5b8235f4651ad6f495bf2ab9fe \
  mips64=2e51acc561a71e9c9e865c0d4f1b38030b8efb454098e60cfe96bbdf3b2f0a5a \
  mips64le=26025d5c7940139c0796180298965c78f5927e706657d59fa4e9b486e444283b \
  loong64=ff0b5ac1c19c0c2baf01d70fc420311f337583aa4f43dba1b60ee11041a10274 \
  riscv64=7240d4b8ecb7e1fd3550763d53a112ad3268970cf4bec2aeda55278e6eed5c69
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
