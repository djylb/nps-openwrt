# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.26
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
  amd64=ecea85524b29c98bbe04654cf30efb923987b6c6b9e24a083fc72e54daea7080 \
  386=6bdcf6eab89bb875d949b87485838bffbbe553f772a47dc202cc616defd43a4c \
  arm64=1f374a6bdb9e81293968d37a58197da1c6c615ffed1051ccd6f16fa5f8930bac \
  arm_v7=8de00e5fd3f161f68249b245a912e0b28538e806f85b788ebd94528be2bf15a3 \
  arm_v6=61dee0f24449461da5728ae99b1c432a25186f7b28fa196ee2abcc2d2c31450b \
  arm_v5=e57ce163a17fbbdf5ca9951e3cf80bb2698494fe245496f4154112783785e70e \
  mips_softfloat=107a0bdcd805c57b9a9a86d084bc4b0d69762875f936cff4f1b355bf4ced97b7 \
  mipsle_softfloat=d72bc357203995d1c1c9db6e0e2fb83c50efc80e6e0c91baa07513905f4f039c \
  mips64=8c67fca13b93c3b7549889800b01269ccf935aaf0df3ff98ff55310f40afea26 \
  mips64le=cb828c64a1aa79b0357d0ccf0ab733b70e52f02615f55d69ed115d5a46d941ca \
  loong64=60c507f48803c2e157ea0b2fe8e0b3f8f16b7d92d328a2afe86dcf2500d03856 \
  riscv64=eed3e354d67adfd6284616cede9decbde525cfc5d6fc3c0b9a1328f8b85af888
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
