# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.49
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
  amd64=a9a1c2b8bc82da7245ad2813d42c24afabe3a9bcb05c74d400f8389397bc274b \
  386=13847506f713fe833b7cab4fc41b912ab9d7c31df742e0c2b1f70cea855aa7be \
  arm64=dabcfc2ab0a31be62c48f8804ec6136fefe6f6d88fa6878a40f6c7680730faf0 \
  arm_v7=6b4a241a3ffca8f57fa310e9debcd55ff12503cfd360bb451a8c00553fd95f4a \
  arm_v6=470db583c426ed0291c550def751df3465a9fa5bbdf0f3256a39df69745bab07 \
  arm_v5=4bf08c5569ea15f2681b1d2cc0871fdb11d53d8c2d1e525e942eaf8ec5883063 \
  mips=577bbfb7008ba89471fb38a632ace42945d5c80c9f81b7271f68d47264423140 \
  mipsle=a9f3046f146656bf864cdf275b586f67c2cc437c36065bd4ab4fcda4ef8de13f \
  mips64=ec5b4bc1a5bf7fafc0e18caf53eb90986fd9fdf34e125c6d6a40363f361f59e1 \
  mips64le=be75ec8b3b454721dbab54df0c3465f6ab7503c941dc980ca219f7d46606d3fd \
  loong64=958536a60938ab0e9539bec3257208ff61a8e06435912628f6eb35feae24c91c \
  riscv64=08a265e1b5c17b0d12de5b47576360b49c86650bca16c02d0ed3a04841e9b123
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
