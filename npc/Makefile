# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.31
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
  amd64=2c1556e0ac92a6b3b0e68705a769e22815006ba4279190a6675ecb05fd5ed1d4 \
  386=98ae1d78698944312a1406bbd479003154ccd43a45a55a5434d2d271dbfad348 \
  arm64=f91de72d7d5da017839d29583f15b7b830407d4964d414d34d2f48d6e11a0f20 \
  arm_v7=7d1a49d7811b4118a45be718178eab2ba79df2321249585e5b3f1997e0790b93 \
  arm_v6=f182311833b61f87fa9e178483b16053d46f341522d79034208bbcb6d8ac1ba2 \
  arm_v5=f110441e883e7f452786ae3f8ca719163bda49271f507525bcc4712f9002c5c4 \
  mips_softfloat=e20845ef54d9bf6e73f5ad87b7fc45430408c9ecb922761133e65dbe32464b12 \
  mipsle_softfloat=aa086cfd22bc513e99200b7ae73168f9db648a51f06837ba2b9f38cd3bdb02ee \
  mips64=aceceb9121900c37e89f871447268fd0e56e8d2e2f0c8e52fc79fbf78c5b67ea \
  mips64le=d876e07e704e3f0e6992f27b5638efe1fc9830220bdb9b04030962a4109b4f64 \
  loong64=f535c1741828e4b44129de9d54f0fb14fadc7be2916f4f67670ebdd5999f1502 \
  riscv64=7a16dbf7f7812d4134005332559a6e73c7078581ebd02a155502e8cdbeefe3f9
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
