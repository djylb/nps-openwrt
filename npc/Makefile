# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.4
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
  amd64=a97eaa122b202b6f15e6999a54a63dff002447ceb5d291dbf9a6f3cd715b8d7a \
  386=d45459d226e4c6dd92ba7c3016a9627459b2eee53eb05fac31af6f5d0048461d \
  arm64=c5cd31aa94e60b26a51a15deb33f7203d520a99b87f7b22911189282e24fa7c9 \
  arm_v7=cee3c2b9fd432ce16c77d4417bd0e6e306971ed61290f66d81321096a7dc198b \
  arm_v6=41bcd953c85cf583afe1dedf57a2048546b29e6268adcf3f357c4d19d53a1d88 \
  arm_v5=ea9a8bf08f17787457222451ed89a1e419c27bef53e063c143f9259c22f1fa52 \
  mips=1f5e6e113bc9818b38b8cf8cc532356c89e26c87135c3cd609f8536da0cf7b31 \
  mipsle=85287f56e7b583abc1526b9a598e835ed7974e4a1caf052e410cf1a39c7112b9 \
  mips64=30ac9daffa79409a346d32db17261439d2fd78fbe96758a38784b093d038c4dc \
  mips64le=7f84590c95d0cd4d3519b61ed7ca906cd5abf98c985e3482b34f845b5288bc9d \
  loong64=78579aa9647bf89bc41f30caeed12915c67c014914d5bb65f509d0761969e5bb \
  riscv64=f1e44dede0ca74eaf1cedf8ec8ab9d293b2f6d3cfd70b5df56601987398681cc
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
