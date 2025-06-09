# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.20
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
  amd64=da0fcce0658528fba66dbe999a37893ae273ba846187982c6230064a06509d1a \
  386=1e53d9a384c78849d220b0e4b8d62870ac1939e889080e22902b9ae125ef78ab \
  arm64=491ddd08b7b9537364d2b3f822a36f4e777c88c210cb6b6d131d2da5eaeec779 \
  arm_v7=05dc78d4bff1f734b7c59429bff4871e830c64103f8278beffc2e6bb574cc579 \
  arm_v6=6f4b86eadc418b0201669a2eb9d9884899d45e2d23729d30db9dbb8c24a7bd35 \
  arm_v5=b6f38505d095bbaca70a3bda4e6fa49045e6a9f15c6c3bc0e5231cb3e3340ba9 \
  mips_softfloat=6ae058a9bd170486802c9cf6516b2077af70583c9bbecbb9388c9d48a0e73d82 \
  mipsle_softfloat=7aaf68108738cd911e78e67c86cf08e5f1c53a9c8b5c97152ac31e4323c69ab2 \
  mips64=fb118c79ee1db757e8dd4bb558a3ba8e3dbbd7759d19be534f9c46bc8e1aa767 \
  mips64le=f5acb7c07d3130118ba357c82aef352d89f5772e0f56bd9f36edd6eeb3a37188 \
  loong64=f892457b6a603e687178f00526cc1d7e2f9ab92793ccd335763789ca4bfd1386 \
  riscv64=9f32273ce79b0afd7a2e3462db61ee4278432244609d11230aba683706c4bd4b
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
