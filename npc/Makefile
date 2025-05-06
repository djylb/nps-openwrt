# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.26.56
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
  amd64=5112a5aaf08c9439b871885bd5c314ce339ee18f3c16339a1233045d833fe655 \
  386=0b380883b6784f58e3e921b3ac49b87f08f442122507d460b4af909a3270a4f5 \
  arm64=7c355e0c05d27b187da15f51c4b333aa3897dd2c70be92607066187027922359 \
  arm_v7=f6658a4ae11c2cea1a08318a0d68e5b5adc7262df56a0b7a7e0fb29ca35b60c7 \
  arm_v6=cbb03ab909d032d9c5ec26097b4de0314269ad54c8a63f38c8a500dd1436be78 \
  arm_v5=7803e2998384569eb25fa838e7b88d364a5bdc9f1f591a319b5f232f7fd71648 \
  mips=2106db7334b1f0b7e1c43a036eafe1101d2b852a5d77df56af24db5fb1a52ffc \
  mipsle=da75cfe7eb217d0367a3ab2bcc535353ed3ff3c6236e833a22fabd442f074974 \
  mips64=1a71ff85d2fdff561bc71713f8c604b198d784a6652a267bd195babde6e6e012 \
  mips64le=1d06d485ae1a2c3af7fcaf0508d56dc6bcc73a7dc0454d159d661cea71a1251d \
  loong64=184f6be7372f896360dd609561f9585b98b41705fee8544b6e5404aa8a99ac21 \
  riscv64=7c7b4c92d00d494d01ccd592543e2ac2a7a018826c7e5475b196f9031f3f1195
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
