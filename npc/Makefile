# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.6
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
  amd64=35438f4cfd4de4991bfef2b9f7b79d6bef88bb55ee07dc42a8acf38f82e5b475 \
  386=003214079061337f154bd3747151d75d9af09a8322a624f30e22414c1b54e88a \
  arm64=f2838e2c699a98c9e9c8b1c5c7e825f409db567ffaa04112619026648b773905 \
  arm_v7=7f1b0ca5fc9bc124798de302ef745b9fbbfc5124cb578854a700cb8dd6451850 \
  arm_v6=0ecfa652a8a9081094a92c4099e76baf286593df4cb1c01d762b4533d5b4433b \
  arm_v5=146b8e939cb87e64570e6f4c4b0f7ede26e512ff90ebdb17a275868248dd8b25 \
  mips=2ef7cbb9bcf4d227a3867278741c3422fc941e8c295e1124dc5c07c679e47ba9 \
  mipsle=c34ad7e3a1de78c051a0013acf79c50ab57b4179967237495d136bf2c3f93eef \
  mips64=f2d96ebc3ae94eba7a425d42adac260c8fb0729513cd12bc0eb26e11958c0dac \
  mips64le=ddc8810765510675172b7c1a125b434c6fb4750d596e25098f82f9e70fb8a937 \
  loong64=ecd67fa1107e2fbbf25fefe79239e307ad47572cbf5c265bc2a05514306d78e7 \
  riscv64=a1a79e68058d138d55424541a70329d47ac19f42cada5af90ce9a7e7988de295
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
