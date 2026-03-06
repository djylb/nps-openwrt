# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.5
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
  amd64=32ae5c8b5c6d68be6710df2830bd930ea295f5402a4a2c078a7aadfb97bb719b \
  386=ab2706cfc9382e6eab9adfd3c516c8149401ede8e16a7c44881101a9ab0434e8 \
  arm64=148b4f09f847d51478e22528c44a3d2645b9166410666cb5e0c4a1b36f0f940e \
  arm_v7=a6b9581547192470fdef3172a439349463cd25d252696aebbee2e54b4e7b0fa8 \
  arm_v6=a32f5b6cec7e82abfe9b243fe1b692c30d7b67d64c2ec35aa124970b186e8453 \
  arm_v5=73010e9f662c531e35fb7200d9f00e90229167c01ae3d9a975a1938d7d07d3f0 \
  mips_softfloat=d7e08cfb2de4f539c4581d974f21a28369413871ee57965b4daaa668e3dfd978 \
  mipsle_softfloat=7310188982a9900e08ff984332074ec17df28b74f4c85ee244a98c1663355ea9 \
  mips64=7bf6277efaf4c1eaf2bb2c543e22616aa8675dd6fa3323e9d525c2a76fcc692e \
  mips64le=c2d08549d08d82017361cdabc2eaf764541963d435f46e4ca7688d96a6299163 \
  loong64=f152d3d39ac30c5a9b7588a28e03c33170b4a1e5bcf796230b36f6c91cfdc976 \
  riscv64=baf658234aa7faeb6e51f6dd72da7f2368196d2454126a6df2b35ddc200fb9b7
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
