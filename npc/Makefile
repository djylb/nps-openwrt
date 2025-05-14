# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.28.0
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
  amd64=d3ee594d60ac1183ce30f0ebcc86fa6c9ac7e5fe7fc904a105b17c99ff46edc7 \
  386=78990468e868ce13cbcfb6cc6190a55a7d323920b9251250c81b32792ec0ca75 \
  arm64=a93d6b1ed99e22781a6782b883d17d50477895b6760c7cc522adbd4326756bdc \
  arm_v7=0519b48d48e087c33f6f9502b44cf88806d4a9ad9da7577e050572a0e478d44a \
  arm_v6=21499c74d7c874224b3267ecf4edadc3f7ab46a171af9b5704cf727fc7d995e6 \
  arm_v5=50b68cb90964341630500a960a2672052d53aef7b989185353103e5125619deb \
  mips=358efd8ebe93699d6a6ae3ba0342917d78d9fdadb7cbd27eaf61c55c951062e3 \
  mipsle=a2dceb2f5ee3ee707321bed756ac5bddb909ec3dc3aac30faa78c232dfde6ce9 \
  mips64=7744e023adb2e163181e44520fa2718251d1e90097c3011e79a378e965ec66de \
  mips64le=3efe9bbdefe5bc964b939bb31be58e25efafcba3d6728314a571b0670e6a5501 \
  loong64=12994973fe9218d781cedb834478d728405dfcb2e9edfa5526fb6375a1f7c9d6 \
  riscv64=02cf01db65dbbc6b98427ed97ff65c1a1a1d574600e745a3069c23b71da4509b
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
