# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.32.8
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
  amd64=06f273cf2270b9193a5b70ce199b2b49bda73295831eaa9ba397a3146b5de3a4 \
  386=1028f701a9fdb7df955931d58e53d905caac97dddb652fc5a31fee5276ed771a \
  arm64=ebfb350b5715451ac11e33b465f6d6b99bdba47ff2c12d2abfc3c04beaa894d8 \
  arm_v7=554f811b4b484fd3402ab8d03b26e4b6bc662a0687b2b692d1292bcb3d8c99b1 \
  arm_v6=eb29a7ec07abca3b4420c3027a7a4ca6e6f60475568f074e6b9bc678615e7316 \
  arm_v5=8ab2de55a307715df1530b30973f557bf1fe1af34151df2951590b48eb93bc96 \
  mips_softfloat=3adbe90d2a127e4b842a58b8d70ba8694db6b46caf193a3629624b7e78973d0c \
  mipsle_softfloat=9472625e48c7591f699b13063e8b96cac85fede4924b4ddf1d56669127b5e4d1 \
  mips64=c9bd5b45505af277f7d8f75ec18786518de698be138274d38310ac19f504136c \
  mips64le=e4d0cea929a2692344536fe146e323b41c1bc42e0221d55ed521d3ddf43d5736 \
  loong64=69872ef7c32a6e96fc68ea2793000632f7e7e2ecea885ce9ba761d6d689137c7 \
  riscv64=8794beb84c5e21a2beddfb20e7afab717a9bb2324b84a4a50c245cfc2b57e5ea
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
