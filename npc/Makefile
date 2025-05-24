# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.8
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
  amd64=eba3381dc1fab7ebba315566c68663785ff7e0ff3ef7d4b4c779c66633273b79 \
  386=e34646fb3dc06c188a830c1dcd7065a696c3e9adbc435580f49d2dcd8d77db79 \
  arm64=5dfbdd0e8091d7a5b85158d77c61f4f908c2af937dfddd9502e245e7d24194a2 \
  arm_v7=a1a6e00346209a6f983139d319b5b5d691d7fc909442e6beee1ae2b9521e5ec1 \
  arm_v6=e76a42ff392795cb1bdfee3f9d0a36eac571aa8e10fd4ddb907513995487cba5 \
  arm_v5=430c410a906aa5222300027f516ab56b30fef8b95669fa2ac4535e466b5fb2fa \
  mips=f65296aaf9531fa7822a0966d8ce5b99988ccba9d0c8a8b1e71fad44fcdd756d \
  mipsle=882dc7d76aec6e4d10ef9dd566ccd9a48fe6f4dc7cf261a3d28fd34a88f9b2dc \
  mips64=385b50868505e1f5ff7b22bb7b2c836f966f7c1272fee487009e7de7407a8346 \
  mips64le=64bb3e715df8e464419e32be9eefe0d5bd4f4f3daa6c0f9d531f986a7390d46c \
  loong64=31adcd7f08e8c9d0d3eb476ab29cca65b0c17d3ebe924a0ea1bcef652d67a476 \
  riscv64=21c762fe71f831f89a797f7de133404708d31e454b8b89480a32d867d3a8faa9
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
