# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.44
PKG_RELEASE:=1

NPC_ARCH:=
ifeq ($(ARCH),x86_64)
    NPC_ARCH:=amd64
else ifeq ($(ARCH),i386)
    NPC_ARCH:=386
else ifeq ($(ARCH),aarch64)
    NPC_ARCH:=arm64
else ifeq ($(findstring armv8,$(BOARD)),armv8)
    NPC_ARCH:=arm64
else ifeq ($(ARCH),arm)
    ifeq ($(BOARD),bcm53xx)
        NPC_ARCH:=arm_v6
    else ifeq ($(BOARD),kirkwood)
        NPC_ARCH:=arm_v5
    else
        NPC_ARCH:=arm_v7
    endif
else ifeq ($(filter mipsel%,$(ARCH)),mipsel)
    NPC_ARCH:=mipsle
else ifeq ($(filter mips64el%,$(ARCH)),mips64el)
    NPC_ARCH:=mips64le
else ifeq ($(filter mips64%,$(ARCH)),mips64)
    NPC_ARCH:=mips64
else ifeq ($(filter mips%,$(ARCH)),mips)
    NPC_ARCH:=mips
else ifeq ($(filter loongarch64%,$(ARCH)),loongarch64)
    NPC_ARCH:=loong64
else ifeq ($(filter riscv64%,$(ARCH)),riscv64)
    NPC_ARCH:=riscv64
else
    $(error Unsupported ARCH: $(ARCH) or BOARD: $(BOARD))
endif

PKG_SOURCE:=linux_$(NPC_ARCH)_client.tar.gz
PKG_SOURCE_URL:=https://github.com/djylb/nps/releases/download/v$(PKG_VERSION)/

# === NPC_HASH_TABLE_START ===
NPC_HASHES := \
  amd64=REPLACE_ME \
  386=REPLACE_ME \
  arm64=REPLACE_ME \
  arm_v7=REPLACE_ME \
  arm_v6=REPLACE_ME \
  arm_v5=REPLACE_ME \
  mips=REPLACE_ME \
  mipsle=REPLACE_ME \
  mips64=REPLACE_ME \
  mips64le=REPLACE_ME \
  loong64=REPLACE_ME \
  riscv64=REPLACE_ME
# === NPC_HASH_TABLE_END ===

PKG_HASH:=$(word 2,$(filter $(NPC_ARCH)=%,$(NPC_HASHES)))

PKG_LICENSE:=Apache-2.0
PKG_MAINTAINER:=Duan <duan@d-jy.net>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=net
    CATEGORY:=Network
    TITLE:=NPC Client (precompiled for $(NPC_ARCH))
    URL:=https://github.com/djylb/nps
endef

define Package/$(PKG_NAME)/description
NPC is a fast reverse proxy client to expose local servers through NAT/firewall.
This package uses the precompiled binary for the $(NPC_ARCH) architecture.
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
    tar -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin/$(PKG_NAME)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
