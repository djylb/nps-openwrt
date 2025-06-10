# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.20
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
  amd64=131ac30325e043041a3bd86634d4553e5b74be4130b3999c697c593af8735a36 \
  386=b2b71bf9707ce72d0447f828a04bccaeb09297c5b5789755b04d34eb0298c2f4 \
  arm64=64d4170efe19d03cf718fecc82e1d4054eeda206ab44c8887f16eac1e8eb8ae8 \
  arm_v7=f13a5159f3819e561ee9e392d228f18acf235300c962ee44503f7944ead2e306 \
  arm_v6=a1f04f6f949af3e6356df3efaa98fc731106a3b9b093519dbca78f0c1107a8bb \
  arm_v5=34caf600523eebfd48da75bb814f7483bbe08ab6bd3a5bab2dc0f74ee51c89fc \
  mips_softfloat=8c922e8108b88a7167bc52ad610724a0f9154dd9cc75b023cfea0a31c19e891b \
  mipsle_softfloat=d1266064aa0e2b65d8adc8e33ab59a00f45d02f96a08afa08eee4ce0e21fc169 \
  mips64=a79e2b0767932ef01c859af38215b77956d48a709196e6ace9d329c517b70442 \
  mips64le=2f6f8d0c954107b44a5bddcd1174031f6a327f5ad3822b9be5d493dbb0d33ec7 \
  loong64=10c305c4ec71f2396c64202e68baf1021935ea6ab2e8c5dcc47e2e92891ecb60 \
  riscv64=d121bf436b85f506060f0c272cabb369c234b9ef0928cad2d868d1fc0e01c5ef
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
