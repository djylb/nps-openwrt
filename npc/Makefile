# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.29.5
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
  amd64=e785b4286b5794f2d8e48b421d0c77534e683c401eabf6a0c65cc0ae7bdcf4af \
  386=4325c189f09ecbd109bd4cc45e41e1db5860d51fc985846cc565e710ddd48366 \
  arm64=354ac39a78dedb6809c2e8c1bdaf84f8ff19c92f6cdb6d2ab5e62920030fa005 \
  arm_v7=bb5767bb81d854fe15a97985300c76ab4085247830fb66da5035e3d89684c7a2 \
  arm_v6=a94c2e63b1e3738f3906e690865d66af1ae175deab3cfa0826c6d67902bf45f3 \
  arm_v5=18e71a158ce3c97d3023bd73fc2e48501728ed9681c9d4dcd27ef43b33c64f2e \
  mips=fb8d8d3261b454e6d2e3ee364a1f38a44b5fc5fcaa9828dd0cc86c6876c27d9d \
  mipsle=96306bc653f5df4eae6f03fbfa074431cac4c55b8c44b4349433056dc06fa057 \
  mips64=86c497c25214a2aeb7f158a8afa23c4cdbddea80177904e3e8ad474b3380d18c \
  mips64le=e2e34301ef40f25fff659955382300b80a84b0bd54fcf9de8b7923721f632c9f \
  loong64=7913df941b2d46d5efc1f782eb9b03aacabaa04320c87d0c28f743a4b3e93b07 \
  riscv64=a594c828922af5b88bd611ed1b79ade4402532bbb55ac1eeefa60625275ae939
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
