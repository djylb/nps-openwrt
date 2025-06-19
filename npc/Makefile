# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.22
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
  amd64=9a7fa9e09099d0d3144c96db9a5735dc50af6a941ea6b2173cb69ebc10c793bf \
  386=22665ab778d9d77ae14c262bee65a532e738e830986e33650872b4d4691d5be9 \
  arm64=49662d3ce837490b7e4c721549cb1ec077e2a9980a265c963582f1c33b58c808 \
  arm_v7=b0f1c20c7f6336311eb403aecb5af48dccb16b83d24a7dc3863b37260ed72f91 \
  arm_v6=e9f46ace651f03cb7ac0ca7d5860d7212a61db650ba2c57a645ea2b537795ffe \
  arm_v5=8c95c41612fcfef4d6e8d382e6eecf7335f55974f1a2ae7ca64317a5669a3a3b \
  mips_softfloat=bd7d9a44ebad800221bf872c5b29d1d765c0493541a3ade8b6e3da259c56a282 \
  mipsle_softfloat=7f33bf6e46acdc7ac52784ff346f22e84ff57386aa550ea33b9ea5ca94152deb \
  mips64=26520d16c3b3492798129f53f8c955e892f92e3185609a54229cac6615a1484f \
  mips64le=77227c6714f6576a4b00bf1d1af39a1ab39ceb21e0f9e3607ab36b270bafa8b7 \
  loong64=559c4390c842d5cee92a114b6f5d5e7eb0f6e29bfdc08a0fb0bbcb206910885c \
  riscv64=2a09ac2e355d4fda32b1a9cddf0b5cd496ed3d81b7e90929a2f8cc6f25ea5632
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
