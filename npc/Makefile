# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.10
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
  amd64=56b3846ef3e9ce16c751d9d287fda35650bf5b747dd324218b3e49573438fe15 \
  386=4b05364c26382c78aacc3f3af4b525da9d31043bbf5cff5637b342517b034c82 \
  arm64=b1049d2662bff29f239d5260bd2935b862c31ca4a5cea580bf9b6576ca95706a \
  arm_v7=a8cc3a3cfda8736535fa36105882d2d42ffce19b95529ec15e03be8c39a2fab0 \
  arm_v6=2672cffe6cb9a18acf5ed2c077b352cf891e6081ad9049cf77a83d115cc9aff0 \
  arm_v5=c9895e49d4c388cb9b9545cf691d604b1ae8a2b6c5dcc37aa51f7b62d8ac4a6d \
  mips=7bb5419a803f3e326e2271216f8b08c02472b0c6629a0183ba3ebd5aa10290bd \
  mipsle=35869e96b015c9d43b7df502ad35f5fe607a193acaea191ddb12534e0c0fb835 \
  mips64=f31910f9f69e50591d5305edf506f3533b1e59903f712bd0eaaf0b0036b5781d \
  mips64le=92e9e897d4b4d476f216e4efd5c3ded06f9bf3695fcdb7217a0f1c51a9a2993e \
  loong64=0c4d57b4c0843e7285711b2c85e036b3b97c9e11298a9768210e03797d023e60 \
  riscv64=23b095e57ef895274fd8c06626ec90bc5370cccb9984f3aefdcb7b73f3573c7c
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
