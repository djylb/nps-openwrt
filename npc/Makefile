# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.13
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
  amd64=b40b6c5c73dc012a17e77f201e074b294af77f05d9be6c3ffb81a4192981d0c3 \
  386=e708c1fb971e4c3c0db558c3887b4f6d1c453b774d2454808ced46f785bfa2b5 \
  arm64=86de37ec2a3a5c81ce0f3f58c2dfc9e47c7b265e2b3baa5309d3676142ecd1fe \
  arm_v7=6c95465a3a8f64e8d7c1527f714c480dab4370eed62f069d5edef29757e5caad \
  arm_v6=f1e72790222936f4e9c00e114a8f437a903438e31621c5823b60fd00683534c6 \
  arm_v5=49542a22d314fe14652719fad9a64cbd93cc1234aa4822d9a7dd965f59559b00 \
  mips_softfloat=b0ab8233f0e363bae73dd6d0e1710605a855ad74902594d436e3fbaa9b2104df \
  mipsle_softfloat=37ca26fe96a30cf63dcbb42e475985be95266eae6fa30426468d50b08cd5a1bc \
  mips64=e699aa79a221189af90f2f5d53eb6a4f937c2ecb31fdad5e0da1db1ba6e973c7 \
  mips64le=65a9ed633f56de6bec0d1a8606872d98d540a0f4af95d36c167b21156f66e96b \
  loong64=c01c4b3f36872ccc2e20eacdde6a915a50e516827c767aec275e30a80dcfe09a \
  riscv64=678e22a7ea87efac756ae4abfd3424f2febfebce1348eba9a1bc336586217692
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
