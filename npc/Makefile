# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.52
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
  amd64=7838df280dd6649fedd0657515b984b2cf3067849535d12708c0593d4000aaa6 \
  386=374a1189f5d65c304e28a8159780148c1dce3d69fe687e9aa067df765ac04338 \
  arm64=790d1e3e6c6625e7dc706c1e1b8dec9c4a84f564c697536a08913e03466a5e53 \
  arm_v7=7f25bf2739d65fb6f4af4c658f5881471cd807929aac43fb835919c08fa9cd48 \
  arm_v6=afdc07f07e96dedd728940f45b4ef82906dd4a566cb8b5ff0faac0d5679d3a9f \
  arm_v5=89a3bc70149380ad5e2c92684e9c7929c0654dbd4472e9bad3a128338eac06cc \
  mips=24a7f3511a659e57468c9fb920e71f9cc37f740610bdef96a5799ed11a7f088a \
  mipsle=f942166b998f9163648a31ee3a5ceff276cace6d1d5e09eb5375c2b3f6becc47 \
  mips64=8bd921faedb3ce0b309ae809c4987a50908d4d494d49527ab771500ddf9b9287 \
  mips64le=13412bfe35ca7f9724dd15a7c11f9a8d82ed728f434cfc5b026e0d1afe5a0448 \
  loong64=3eb4268a2964bb83af001441b3a639944e6af1c6ecb034cfa0b24b188ef1e7f5 \
  riscv64=28214627974dbd083627237fff5ee35aee4ff2ceecc5de280e9e9433686d2c8b
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
