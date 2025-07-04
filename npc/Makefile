# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.32
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
  amd64=7a6d028c4de98fbe50db5e03fbaf0d3e4158f473a76a4dcaa6eb5d53cc1b4b95 \
  386=8bde0526ae31a3c17001f3ea343e9711bc1e4374201cb69fca99d3b43d6fc448 \
  arm64=1a63c43ab9fa62e73ce8024d2b5804ad729b98534227988dcf21307e9b22c36d \
  arm_v7=ed41d65e2ab136fe4fe063d822687cbacd77e83583d4f0958b679ee6154c41d2 \
  arm_v6=02705fc89edff50e7abdeab9d02f410a5c89e8d4e16eca853c150cd308138f00 \
  arm_v5=66a2b90d0f9e913d256ea64508ef8cb3e7840ff007ea8016a30823d4ff59c62d \
  mips_softfloat=fbda69b50ac4475d3c42afd3aab5e8ae12b3a7a57a4b55b5970338d7ad056957 \
  mipsle_softfloat=645e3f5ac0f19b8569fa9312c5937534b85c1ce59eef0e8e59a9c3d2bae719ab \
  mips64=ade736232ef9b5bd802d38d4f41d7290d987409ca3a99873620c8d052d370631 \
  mips64le=8e9d5a3ffe8c2e3d476b78f4bf573a7d2e7ebd8a47d8179338032942bfa74860 \
  loong64=c8a8357d442f6c2f85c87502129656145d029512982c0556ea4b4e3eac1bdd91 \
  riscv64=597ea6bf7cfdb29f7abd178b6afdee6e2c3a09767b0a72600bee964fc8def71a
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
