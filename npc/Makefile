# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.33.11
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
		NPC_ARCH:=arm_v7
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
  amd64=ac7d5432486f4851c50c01be9d513fc1ae423770f1e696cd29f239e2fd92390c \
  386=b047f6c40f00b69ed8490da8d06bdcd7103771e6c305a3ab50fd90582bf2c1e0 \
  arm64=1b0f6cc6e07a3b1c8fa080330fe1d0b017db9ece2dd016ec2e484a4a37ca5871 \
  arm_v7=8ab518e0375d647eed7a4a8e797f65c4d7c0439b5168fe904a6ad855064dcb63 \
  arm_v6=826e1c786c22cdc2be95e3a3b664f5e05218363e7f29ef82e9d18d0a31e67d2a \
  arm_v5=f7be81d9e3559ba390fb8d7413e2246035aaff464f1483e5c59f00c27c76b2d5 \
  mips_softfloat=8cf66e1a347eeaa48e1469a79f2acb48742a1e67a2aec232312bd41ce81c3e95 \
  mipsle_softfloat=504001aad7832ee69807ecd2ec511af219b2b6721a94836903d766a920f743fb \
  mips64=cd34a51a95293817884904cae0c5e1f09cb82d1378cb8a6f7726ee0b9e55cc68 \
  mips64le=e232fdeff5c22bff48aaf635b02397b11c9c3eed03c230587bff4fb83bf15f85 \
  loong64=60865d7c66c9c4177f2526e3963ba6bdde2bcc8e9799fc309b5829a725f79e12 \
  riscv64=b4031a9db6b84ee9fd2c6590978cec47d86ee29a1e14771928d306e6e3bce2bf
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
