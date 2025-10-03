# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.9
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
  amd64=570911834f36ab2b3aed6059664d60d0720b42ffa5dc1730517342795d480a69 \
  386=8a3c3f8414e350ac522a8a27c3daf97e532df6b2d5cc8c968a0363bc06e0a274 \
  arm64=aa6f475dad1dfa364e4939ff98cfc56d668e51c235690a3fa167fdaeeccfa9f3 \
  arm_v7=0c9b4df83f811a8c0dcbe5acc4788a14e3bd07737150881754df6cb12863a375 \
  arm_v6=1e100c6f1c7af098f1326096f365bd0ac9ecdb7884ea547fb35c4465b30aa8cf \
  arm_v5=bcf2a41cfff5bb5ab7af67911d889274c41103f37dd4fbbe491a8864b1afcbda \
  mips_softfloat=ba621f4653fb71030d74e41744692422bbc853957cc25cedea71f9797b86ffc5 \
  mipsle_softfloat=ce209dddca0a2d2a50803b054b6df01fc3ff022d156474ab606821336820ab91 \
  mips64=b34c4f5de27e54937c8e5873d9cd2106d0c48777a525216405c15faba8b750d6 \
  mips64le=14cf18e2d8724155d21243a88513ce731bb8398161fc028a24fcc1d95d58289f \
  loong64=b9880b595df593a2077d921c3f8fd2e0251092028a7c49765a097b96a35224d1 \
  riscv64=9b224ba477bde8b6f5b974c5f68f78f62b11921614e77ba4e890fc8666875920
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
