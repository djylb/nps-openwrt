# Copyright (C) 2024-2025 Duan <duan@d-jy.net>

include $(TOPDIR)/rules.mk

PKG_NAME:=npc
PKG_VERSION:=0.34.8
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
  amd64=28b2fa9f5942545460eec19bfc027032605ae86fc4418aca6cad3e0edabec7bd \
  386=e25fd099dd7d2af2f356270d2801ad5fdfbac26a2539c7782fc728298e19bcbb \
  arm64=15c6db35aad3db092656b77ba407533bb595bdc4facf9dfa30b40eb3bad7f96e \
  arm_v7=20043b00ba15588dbaaeebb61261734c731ee449c61e70baff0938544c69d94f \
  arm_v6=3ceb17e6d490294bfd166749cd841f4c4eeac704a9caf60c09f04093b037207e \
  arm_v5=94f4559bbba59ab712af9a51cfbaa043643b6517feff1c832ead5c5b9744ae3d \
  mips_softfloat=d7fdcfbc6bb1f8ede281dfcc023de4afebc81ec3e1c612d6944a2716f26c7b2d \
  mipsle_softfloat=6a175222d554574fc4d105d716596cad0c6e4fe2219548c8b3691eb56c044503 \
  mips64=f4415c072ec94cf99ebe910778c955cabdd2d38e5d18ef069af4083599962388 \
  mips64le=8d02cd2549865b20933fc8815d1a52743edc6bc1d112fd05c50fc3a26fc52158 \
  loong64=81ac4ef83d3595f1a9a470915fcd4575c553c42506e32de1d4f9a348f3d2cf51 \
  riscv64=4884166ae261f2c6eb8933282cda283139801c25900640bcb415b602b23712a0
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
